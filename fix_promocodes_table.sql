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

-- 2. Drop the CHECK constraint if it exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS WHERE CONSTRAINT_NAME = 'CK__PromoCode__disco__5BE2A6F2')
BEGIN
    ALTER TABLE dbo.PromoCodes DROP CONSTRAINT CK__PromoCode__disco__5BE2A6F2;
    PRINT 'Dropped existing CHECK constraint on discount_type column';
END
GO

-- 3. Increase discount_type column size to accommodate 'FIXED_AMOUNT'
ALTER TABLE dbo.PromoCodes ALTER COLUMN discount_type VARCHAR(20) NOT NULL;
PRINT 'Updated discount_type column size to VARCHAR(20)';
GO

-- 4. Add new CHECK constraint to allow both PERCENTAGE and FIXED_AMOUNT
ALTER TABLE dbo.PromoCodes ADD CONSTRAINT CK_PromoCodes_discount_type 
    CHECK (discount_type IN ('PERCENTAGE', 'FIXED_AMOUNT'));
PRINT 'Added new CHECK constraint for discount_type values';
GO

-- 5. Update existing records to have created_at if they don't have it
UPDATE dbo.PromoCodes SET created_at = GETDATE() WHERE created_at IS NULL;
PRINT 'Updated existing records with created_at timestamp';

PRINT 'PromoCodes table schema updated successfully!';
