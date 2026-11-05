create database project;
use project;
DESCRIBE messed_targets;
ALTER TABLE messed_targets
CHANGE `ï»¿EmployeeID` EmployeeID DOUBLE;
ALTER TABLE messed_targets
CHANGE `ï»¿EmployeeID` EmployeeID DOUBLE;
DESCRIBE messed_targets;
SELECT * FROM messed_targets LIMIT 20;
UPDATE messed_targets
SET EmployeeID = 191644724
WHERE EmployeeID = -191644724;
UPDATE messed_targets
SET Target = TRIM(REPLACE(Target, '$', ''));
UPDATE messed_targets
SET TargetMonth = TRIM(TargetMonth);
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
SELECT EmployeeID, Target, HEX(Target)
FROM messed_targets
WHERE Target IS NOT NULL
  AND TRIM(Target) NOT REGEXP '^[0-9]+(\.[0-9]+)?$'
LIMIT 20;
UPDATE messed_targets
SET Target = NULL
WHERE TRIM(Target) = '';
UPDATE messed_targets
SET Target = REPLACE(Target, ',', '');
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
SELECT DISTINCT TargetMonth
FROM messed_targets;
UPDATE messed_targets
SET TargetMonth = NULL
WHERE TRIM(TargetMonth) = '';
UPDATE messed_targets
SET TargetMonth = 'Monday, June 1, 2020'
WHERE LOWER(TRIM(TargetMonth)) = 'monday, june 1, 2020';
DESCRIBE messed_targets;
ALTER TABLE messed_targets
CHANGE `ï»¿EmployeeID` EmployeeID DOUBLE;
ALTER TABLE messed_targets
CHANGE `ï»¿EmployeeID` EmployeeID DOUBLE;
DESCRIBE messed_targets;
SELECT * FROM messed_targets LIMIT 20;
UPDATE messed_targets
SET EmployeeID = 191644724
WHERE EmployeeID = -191644724;
UPDATE messed_targets
SET Target = TRIM(REPLACE(Target, '$', ''));
UPDATE messed_targets
SET TargetMonth = TRIM(TargetMonth);
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
SELECT EmployeeID, Target, HEX(Target)
FROM messed_targets
WHERE Target IS NOT NULL
  AND TRIM(Target) NOT REGEXP '^[0-9]+(\.[0-9]+)?$'
LIMIT 20;
UPDATE messed_targets
SET Target = NULL
WHERE TRIM(Target) = '';
UPDATE messed_targets
SET Target = REPLACE(Target, ',', '');
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
SELECT DISTINCT TargetMonth
FROM messed_targets;
UPDATE messed_targets
SET TargetMonth = NULL
WHERE TRIM(TargetMonth) = '';
UPDATE messed_targets
SET TargetMonth = 'Monday, June 1, 2020'
WHERE LOWER(TRIM(TargetMonth)) = 'monday, june 1, 2020';
DESCRIBE messed_targets;
ALTER TABLE messed_targets
CHANGE `ï»¿EmployeeID` EmployeeID DOUBLE;
ALTER TABLE messed_targets
CHANGE `ï»¿EmployeeID` EmployeeID DOUBLE;
DESCRIBE messed_targets;
SELECT * FROM messed_targets LIMIT 20;
UPDATE messed_targets
SET EmployeeID = 191644724
WHERE EmployeeID = -191644724;
UPDATE messed_targets
SET Target = TRIM(REPLACE(Target, '$', ''));
UPDATE messed_targets
SET TargetMonth = TRIM(TargetMonth);
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
SELECT EmployeeID, Target, HEX(Target)
FROM messed_targets
WHERE Target IS NOT NULL
  AND TRIM(Target) NOT REGEXP '^[0-9]+(\.[0-9]+)?$'
LIMIT 20;
UPDATE messed_targets
SET Target = NULL
WHERE TRIM(Target) = '';
UPDATE messed_targets
SET Target = REPLACE(Target, ',', '');
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
ALTER TABLE messed_targets
MODIFY Target DOUBLE;
SELECT DISTINCT TargetMonth
FROM messed_targets;
UPDATE messed_targets
SET TargetMonth = NULL
WHERE TRIM(TargetMonth) = '';
UPDATE messed_targets
SET TargetMonth = 'Monday, June 1, 2020'
WHERE LOWER(TRIM(TargetMonth)) = 'monday, june 1, 2020';
DESCRIBE messed_targets;
