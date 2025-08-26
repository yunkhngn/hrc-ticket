USE hrc;
GO

-- Fix PromoCodes table schema issues

-- 1. Add missing created_at column first
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

-- 2. Increase discount_type column size to accommodate 'FIXED_AMOUNT'
ALTER TABLE dbo.PromoCodes ALTER COLUMN discount_type VARCHAR(20) NOT NULL;
PRINT 'Updated discount_type column size to VARCHAR(20)';
GO

-- 3. Update existing records to have created_at if they don't have it
UPDATE dbo.PromoCodes SET created_at = GETDATE() WHERE created_at IS NULL;
PRINT 'Updated existing records with created_at timestamp';

PRINT 'PromoCodes table schema updated successfully!';
