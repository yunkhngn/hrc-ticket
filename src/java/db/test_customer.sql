-- Test Customer for HRC Login Testing
-- Password: 123456 (hashed with SHA-256)

INSERT INTO Customers (email, full_name, phone, password_hash, created_at)
VALUES (
    'customer@test.com',
    'Test Customer',
    '0123456789',
    '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', -- password: 123456
    GETDATE()
);

-- Alternative test customer with password: password
-- INSERT INTO Customers (email, full_name, phone, password_hash, created_at)
-- VALUES (
--     'test@test.com',
--     'Simple Test Customer',
--     '0987654321',
--     '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', -- password: password
--     GETDATE()
-- );
