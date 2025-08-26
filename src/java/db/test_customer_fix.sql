-- Test customer với password đúng
-- Password: 123456
-- SHA-256 hash: 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92

-- Xóa customer cũ nếu có
DELETE FROM Customers WHERE email = 'test@example.com';

-- Thêm customer mới
INSERT INTO Customers (email, password, firstName, lastName, phone, address, createdAt, updatedAt)
VALUES (
    'test@example.com',
    '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
    'Test',
    'Customer',
    '0123456789',
    'Hanoi, Vietnam',
    GETDATE(),
    GETDATE()
);

-- Thêm user record tương ứng
INSERT INTO Users (email, password, role, createdAt, updatedAt)
VALUES (
    'test@example.com',
    '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',
    'CUSTOMER',
    GETDATE(),
    GETDATE()
);

PRINT 'Test customer created successfully!';
PRINT 'Email: test@example.com';
PRINT 'Password: 123456';
