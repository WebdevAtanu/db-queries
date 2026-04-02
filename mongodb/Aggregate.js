// 1. Get top 5 users by total order amount
db.orders.aggregate([
    {
        $group: {
            _id: "$userId",
            totalSpent: { $sum: "$amount" }
        }
    },
    { $sort: { totalSpent: -1 } },
    { $limit: 5 }
]);


// 2. Join users with orders and calculate total orders per user
db.users.aggregate([
    {
        $lookup: {
            from: "orders",
            localField: "_id",
            foreignField: "userId",
            as: "orders"
        }
    },
    {
        $project: {
            name: 1,
            totalOrders: { $size: "$orders" }
        }
    }
]);


// 3. Get users with more than 3 orders
db.users.aggregate([
    {
        $lookup: {
            from: "orders",
            localField: "_id",
            foreignField: "userId",
            as: "orders"
        }
    },
    {
        $match: {
            $expr: { $gt: [{ $size: "$orders" }, 3] }
        }
    }
]);


// 4. Monthly sales report
db.orders.aggregate([
    {
        $group: {
            _id: { month: { $month: "$createdAt" } },
            totalSales: { $sum: "$amount" }
        }
    },
    { $sort: { "_id.month": 1 } }
]);


// 5. Get most popular product (based on quantity sold)
db.orders.aggregate([
    { $unwind: "$items" },
    {
        $group: {
            _id: "$items.productId",
            totalSold: { $sum: "$items.quantity" }
        }
    },
    { $sort: { totalSold: -1 } },
    { $limit: 1 }
]);


// 6. Get average order value per user
db.orders.aggregate([
    {
        $group: {
            _id: "$userId",
            avgOrderValue: { $avg: "$amount" }
        }
    }
]);


// 7. Find inactive users (no orders)
db.users.aggregate([
    {
        $lookup: {
            from: "orders",
            localField: "_id",
            foreignField: "userId",
            as: "orders"
        }
    },
    {
        $match: {
            orders: { $size: 0 }
        }
    }
]);


// 8. Get users with latest order
db.users.aggregate([
    {
        $lookup: {
            from: "orders",
            let: { userId: "$_id" },
            pipeline: [
                { $match: { $expr: { $eq: ["$userId", "$$userId"] } } },
                { $sort: { createdAt: -1 } },
                { $limit: 1 }
            ],
            as: "latestOrder"
        }
    }
]);


// 9. Calculate total revenue per day
db.orders.aggregate([
    {
        $group: {
            _id: {
                day: { $dayOfMonth: "$createdAt" },
                month: { $month: "$createdAt" },
                year: { $year: "$createdAt" }
            },
            revenue: { $sum: "$amount" }
        }
    }
]);


// 10. Get products with stock less than threshold
db.products.find({
    stock: { $lt: 10 }
});


// 11. Complex filter + projection + sorting
db.users.find(
    { age: { $gt: 20 }, status: "active" },
    { name: 1, age: 1 }
).sort({ age: -1 });


// 12. Multi-condition aggregation with match
db.orders.aggregate([
    {
        $match: {
            status: "completed",
            amount: { $gt: 1000 }
        }
    },
    {
        $group: {
            _id: "$userId",
            total: { $sum: "$amount" }
        }
    }
]);


// 13. Nested lookup (users → orders → products)
db.users.aggregate([
    {
        $lookup: {
            from: "orders",
            localField: "_id",
            foreignField: "userId",
            as: "orders"
        }
    },
    { $unwind: "$orders" },
    {
        $lookup: {
            from: "products",
            localField: "orders.productId",
            foreignField: "_id",
            as: "product"
        }
    }
]);


// 14. Get order count by status
db.orders.aggregate([
    {
        $group: {
            _id: "$status",
            count: { $sum: 1 }
        }
    }
]);


// 15. Find duplicate emails
db.users.aggregate([
    {
        $group: {
            _id: "$email",
            count: { $sum: 1 }
        }
    },
    {
        $match: {
            count: { $gt: 1 }
        }
    }
]);


// 16. Add computed field (full name)
db.users.aggregate([
    {
        $addFields: {
            fullName: { $concat: ["$firstName", " ", "$lastName"] }
        }
    }
]);


// 17. Bucket users by age groups
db.users.aggregate([
    {
        $bucket: {
            groupBy: "$age",
            boundaries: [0, 18, 30, 50, 100],
            default: "Other",
            output: {
                count: { $sum: 1 }
            }
        }
    }
]);


// 18. Faceted search (pagination + count)
db.products.aggregate([
    {
        $facet: {
            data: [{ $skip: 0 }, { $limit: 10 }],
            totalCount: [{ $count: "count" }]
        }
    }
]);


// 19. Graph lookup (hierarchical data, e.g., categories)
db.categories.aggregate([
    {
        $graphLookup: {
            from: "categories",
            startWith: "$parentId",
            connectFromField: "parentId",
            connectToField: "_id",
            as: "hierarchy"
        }
    }
]);


// 20. Transaction-like bulk operation (Node.js)
async function transferMoney(db, fromUser, toUser, amount) {
    const session = db.startSession();

    session.startTransaction();

    try {
        await db.collection("users").updateOne(
            { _id: fromUser },
            { $inc: { balance: -amount } },
            { session }
        );

        await db.collection("users").updateOne(
            { _id: toUser },
            { $inc: { balance: amount } },
            { session }
        );

        await session.commitTransaction();
        session.endSession();
    } catch (err) {
        await session.abortTransaction();
        session.endSession();
    }
}