USE hrc;
GO

-- Simple and robust fix for PromoCodes table schema issues

PRINT 'Starting PromoCodes table schema fix...';

-- 1. Add missing created_at column if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'PromoCodes' AND COLUMN_NAME = 'created_at')
BEGIN
    ALTER TABLE dbo.PromoCodes ADD created_at DATETIME2 DEFAULT GETDATE();
    PRINT 'Added created_at column to PromoCodes table';
END
ELSE
BEGIN
    PRINT 'created_at column already exists in PromoCodes table';
END
GO

-- 2. Update existing records to have created_at if they don't have it
UPDATE dbo.PromoCodes SET created_at = GETDATE() WHERE created_at IS NULL;
PRINT 'Updated existing records with created_at timestamp';
GO

-- 3. Drop existing CHECK constraints on discount_type column (if any)
DECLARE @constraint_name NVARCHAR(128)
DECLARE @sql NVARCHAR(MAX)

-- Find and drop all CHECK constraints on discount_type
SELECT @constraint_name = cc.CONSTRAINT_NAME 
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS cc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON cc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
WHERE ccu.TABLE_NAME = 'PromoCodes' AND ccu.COLUMN_NAME = 'discount_type'

IF @constraint_name IS NOT NULL
BEGIN
    SET @sql = 'ALTER TABLE dbo.PromoCodes DROP CONSTRAINT [' + @constraint_name + ']'
    EXEC sp_executesql @sql
    PRINT 'Dropped existing CHECK constraint: ' + @constraint_name
END
ELSE
BEGIN
    PRINT 'No existing CHECK constraints found on discount_type column'
END
GO

-- 4. Increase discount_type column size to accommodate 'FIXED_AMOUNT'
ALTER TABLE dbo.PromoCodes ALTER COLUMN discount_type VARCHAR(20) NOT NULL;
PRINT 'Updated discount_type column size to VARCHAR(20)';
GO

-- 5. Add new CHECK constraint to allow both PERCENTAGE and FIXED_AMOUNT
ALTER TABLE dbo.PromoCodes ADD CONSTRAINT CK_PromoCodes_discount_type 
    CHECK (discount_type IN ('PERCENTAGE', 'FIXED_AMOUNT'));
PRINT 'Added new CHECK constraint for discount_type values (PERCENTAGE, FIXED_AMOUNT)';
GO

-- 6. Verify the changes
PRINT 'Verifying changes...';

SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'PromoCodes' AND COLUMN_NAME IN ('discount_type', 'created_at');

SELECT 
    cc.CONSTRAINT_NAME,
    cc.CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS cc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON cc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
WHERE ccu.TABLE_NAME = 'PromoCodes' AND ccu.COLUMN_NAME = 'discount_type';

PRINT 'PromoCodes table schema updated successfully!';
PRINT 'The table now supports both PERCENTAGE and FIXED_AMOUNT discount types.';
