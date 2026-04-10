-- String functions
SELECT UPPER(FirstName) AS UpperFirstName FROM Employees -- convert FirstName to uppercase
SELECT LOWER(LastName) AS LowerLastName FROM Employees -- convert LastName to lowercase
SELECT FirstName, LEN(FirstName) AS FirstNameLength FROM Employees -- get length of FirstName
SELECT SUBSTRING(LastName, 1, 3) AS LastNameSubstring FROM Employees -- get substring of LastName
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees -- concatenate FirstName and LastName
SELECT REPLACE(LastName, 'Smith', 'Johnson') AS UpdatedLastName FROM Employees -- replace 'Smith' with 'Johnson' in LastName
SELECT LTRIM(RTRIM(FirstName)) AS TrimmedFirstName FROM Employees -- trim leading and trailing spaces from FirstName
SELECT CHARINDEX('o', LastName) AS PositionOfO FROM Employees -- find position of 'o' in LastName
SELECT CAST(Salary AS NVARCHAR(20)) AS SalaryAsString FROM Employees -- convert Salary to string
SELECT FORMAT(HireDate, 'yyyy-MM-dd') AS FormattedHireDate FROM Employees -- format HireDate to 'yyyy-MM-dd'
SELECT LEFT(FirstName, 2) AS FirstTwoChars FROM Employees -- get the first two characters of FirstName
SELECT RIGHT(LastName, 3) AS LastThreeChars FROM Employees -- get the last three characters of LastName
SELECT REVERSE(FirstName) AS ReversedFirstName FROM Employees -- reverse the characters in FirstName
SELECT STUFF(LastName, 2, 3, 'XXX') AS ModifiedLastName FROM Employees -- replace characters in LastName using STUFF function
SELECT DIFFERENCE(FirstName, 'John') AS SoundexDifference FROM Employees -- compare soundex values of FirstName with 'John'
SELECT SOUNDEX(LastName) AS LastNameSoundex FROM Employees -- get soundex value of LastName
SELECT REPLICATE(FirstName, 2) AS RepeatedFirstName FROM Employees -- repeat FirstName twice
SELECT PARSENAME('www.example.com', 1) AS TopLevelDomain -- get the top-level domain from a URL
SELECT STRING_AGG(LastName, ', ') AS AllLastNames FROM Employees -- aggregate LastNames into a single string
SELECT TRANSLATE(FirstName, 'aeiou', '12345') AS TranslatedFirstName FROM Employees -- translate vowels in FirstName to numbers
SELECT TRIM(FirstName) AS TrimmedFirstName FROM Employees -- trim spaces from both ends of FirstName
SELECT FORMATMESSAGE('Employee: %s %s', FirstName, LastName) AS FormattedMessage FROM Employees -- format a message with FirstName and LastName
SELECT CONCAT_WS('-', FirstName, LastName) AS FullNameWithSeparator FROM Employees -- concatenate FirstName and LastName with a separator
SELECT CONCAT_WS(' - ', FirstName, LastName, CAST(Salary AS NVARCHAR(20))) AS EmployeeInfo FROM Employees -- concatenate multiple fields with a separator
