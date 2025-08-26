-- Update admin password for admin@rock.local
-- Password: admin123 (SHA-256 hash)
UPDATE dbo.Users 
SET password_hash = '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'
WHERE email = 'admin@rock.local';

-- Also create admin@hrc.com if it doesn't exist
IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE email = 'admin@hrc.com')
BEGIN
    INSERT INTO dbo.Users(email, full_name, phone, role, active, password_hash, created_at)
    VALUES ('admin@hrc.com', N'HRC Administrator', '0123456789', 'ADMIN', 1, 
            '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 
            SYSDATETIME());
END
ELSE
BEGIN
    -- Update existing admin@hrc.com password
    UPDATE dbo.Users 
    SET password_hash = '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'
    WHERE email = 'admin@hrc.com';
END

-- Verify the updates
SELECT id, email, full_name, role, active, 
       CASE WHEN password_hash IS NULL THEN 'NULL' ELSE 'SET' END as password_status
FROM dbo.Users 
WHERE email IN ('admin@rock.local', 'admin@hrc.com');
