-- primary key
CREATE TABLE user(userId INT AUTO_INCREMENT PRIMARY KEY, 
userName VARCHAR(255), 
Email VARCHAR(255), 
userPassword VARCHAR(255));

-- unique
CREATE TABLE user(userId INT AUTO_INCREMENT PRIMARY KEY, 
userName VARCHAR(255), 
Email VARCHAR(255) UNIQUE, 
userPassword VARCHAR(255));

-- check
CREATE TABLE user(userId INT AUTO_INCREMENT PRIMARY KEY, 
userName VARCHAR(255), 
Email VARCHAR(255), 
userPassword VARCHAR(255) password_is_too_short CHECK (userPassword > 6)); -- password is too short error will be thrown if password length is less than 6

-- default
CREATE TABLE user(userId INT AUTO_INCREMENT PRIMARY KEY, 
userName VARCHAR(255), 
Email VARCHAR(255), 
userPassword VARCHAR(255) DEFAULT "123456");

-- foreign key
CREATE TABLE orders(orderId INT AUTO_INCREMENT PRIMARY KEY,
userId INT,
FOREIGN KEY (userId) REFERENCES user(userId));

-- not null
CREATE TABLE user(userId INT AUTO_INCREMENT PRIMARY KEY, 
userName VARCHAR(255) NOT NULL, 
Email VARCHAR(255), 
userPassword VARCHAR(255));