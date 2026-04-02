// 1. Insert one document
db.users.insertOne({ name: "Atanu", age: 26 });

// 2. Insert multiple documents
db.users.insertMany([
    { name: "A", age: 20 },
    { name: "B", age: 25 }
]);

// 3. Find all documents
db.users.find();

// 4. Find one document by name
db.users.findOne({ name: "Atanu" });

// 5. Find with condition 
db.users.find({ age: 26 });

// 6. Projection (include fields)
db.users.find({}, { name: 1, age: 1 });

// 7. Exclude field
db.users.find({}, { password: 0 });

// 8. Count documents
db.users.countDocuments();

// 9. Sort ascending
db.users.find().sort({ age: 1 });

// 10. Sort descending
db.users.find().sort({ age: -1 });

// 11. Limit results
db.users.find().limit(5);

// 12. Skip (pagination)
db.users.find().skip(10).limit(5);

// 13. Distinct values
db.users.distinct("age");

// 14. Drop collection
db.users.drop();

// 15. Delete all documents
db.users.deleteMany({});

// 16. Greater than
db.users.find({ age: { $gt: 20 } });

// 17. Less than
db.users.find({ age: { $lt: 30 } });

// 18. Between
db.users.find({ age: { $gte: 20, $lte: 30 } });

// 19. Not equal
db.users.find({ age: { $ne: 25 } });

// 20. IN operator
db.users.find({ age: { $in: [20, 25] } });

// 21. NOT IN
db.users.find({ age: { $nin: [20, 25] } });

// 22. AND condition (both conditions must be true)
db.users.find({
    $and: [{ age: 25 }, { name: "A" }]
});

// 23. OR condition (at least one condition must be true)
db.users.find({
    $or: [{ age: 25 }, { name: "A" }]
});

// 24. Field exists 
db.users.find({ email: { $exists: true } });

// 25. Regex search (case insensitive)
db.users.find({ name: { $regex: "At", $options: "i" } });

// 26. Array size 
db.users.find({ skills: { $size: 3 } });

// 27. Element match (array of objects)
db.users.find({
    skills: { $elemMatch: { name: "Node", level: "advanced" } }
});

// 28. Type check
db.users.find({ age: { $type: "int" } });

// 29. Nested field query
db.users.find({ "address.city": "Kolkata" });

// 30. Exact match (case insensitive)
db.users.find({ name: { $regex: "^atanu$", $options: "i" } });

// 31. Update one
db.users.updateOne(
    { name: "Atanu" },
    { $set: { age: 27 } }
);

// 32. Update many
db.users.updateMany(
    { age: 25 },
    { $set: { status: "active" } }
);

// 33. Increment value
db.users.updateOne(
    { name: "Atanu" },
    { $inc: { age: 1 } }
);

// 34. Rename field 
db.users.updateOne(
    {},
    { $rename: { name: "fullName" } }
);

// 35. Remove field
db.users.updateOne(
    {},
    { $unset: { age: "" } }
);

// 36. Push into array
db.users.updateOne(
    { name: "Atanu" },
    { $push: { skills: "MongoDB" } }
);

// 37. Add unique value
db.users.updateOne(
    { name: "Atanu" },
    { $addToSet: { skills: "Node" } }
);

// 38. Remove from array
db.users.updateOne(
    { name: "Atanu" },
    { $pull: { skills: "MongoDB" } }
);

// 39. Upsert (insert if not exists)
db.users.updateOne(
    { name: "NewUser" },
    { $set: { age: 22 } },
    { upsert: true }
);

// 40. Find and update
db.users.findOneAndUpdate(
    { name: "Atanu" },
    { $set: { age: 30 } },
    { new: true }
);

// 41. Match stage 
db.users.aggregate([
    { $match: { age: { $gt: 20 } } }
]);

// 42. Group by field
db.users.aggregate([
    {
        $group: {
            _id: "$age",
            count: { $sum: 1 }
        }
    }
]);

// 43. Average calculation
db.users.aggregate([
    {
        $group: {
            _id: null,
            avgAge: { $avg: "$age" }
        }
    }
]);

// 44. Lookup (JOIN)
db.orders.aggregate([
    {
        $lookup: {
            from: "users",
            localField: "userId",
            foreignField: "_id",
            as: "user"
        }
    }
]);

// 45. Unwind array
db.users.aggregate([
    { $unwind: "$skills" }
]);

// 46. Project fields
db.users.aggregate([
    {
        $project: {
            name: 1,
            isAdult: { $gte: ["$age", 18] }
        }
    }
]);

// 47. Sort in aggregation
db.users.aggregate([
    { $sort: { age: -1 } }
]);

// 48. Pagination in aggregation
db.users.aggregate([
    { $skip: 10 },
    { $limit: 5 }
]);

// 49. Multi-stage pipeline
db.orders.aggregate([
    { $match: { status: "completed" } },
    {
        $group: {
            _id: "$userId",
            total: { $sum: "$amount" }
        }
    },
    { $sort: { total: -1 } }
]);

// 50. Facet (multiple pipelines)
db.users.aggregate([
    {
        $facet: {
            young: [{ $match: { age: { $lt: 25 } } }],
            old: [{ $match: { age: { $gte: 25 } } }]
        }
    }
]);


// Pagination + filtering example
async function getUsers() {
    const users = await User.find({ age: { $gt: 20 } })
        .select("name age")
        .sort({ age: -1 })
        .skip(10)
        .limit(5);

    return users;
}