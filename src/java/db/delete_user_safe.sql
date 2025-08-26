-- =========================================
-- Safe User Deletion Script
-- =========================================
USE hrc;
GO

-- Check which user we want to delete (ID 1 = admin@rock.local)
DECLARE @UserIdToDelete BIGINT = 1;
DECLARE @UserEmail NVARCHAR(150);

-- Get the user email for confirmation
SELECT @UserEmail = email FROM dbo.Users WHERE id = @UserIdToDelete;

IF @UserEmail IS NULL
BEGIN
    PRINT 'User not found!';
    RETURN;
END

PRINT 'About to delete user: ' + @UserEmail;

-- Check if any orders are confirmed by this user
DECLARE @OrderCount INT;
SELECT @OrderCount = COUNT(*) FROM dbo.Orders WHERE confirmed_by = @UserIdToDelete;

IF @OrderCount > 0
BEGIN
    PRINT 'WARNING: This user has confirmed ' + CAST(@OrderCount AS VARCHAR) + ' orders.';
    PRINT 'Setting confirmed_by to NULL for these orders...';
    
    -- Update orders to remove the confirmed_by reference
    UPDATE dbo.Orders 
    SET confirmed_by = NULL, confirmed_at = NULL
    WHERE confirmed_by = @UserIdToDelete;
    
    PRINT 'Orders updated successfully.';
END
ELSE
BEGIN
    PRINT 'No orders confirmed by this user.';
END

-- Now delete the user
DELETE FROM dbo.Users WHERE id = @UserIdToDelete;

-- Verify deletion
IF @@ROWCOUNT > 0
BEGIN
    PRINT 'User ' + @UserEmail + ' has been successfully deleted!';
END
ELSE
BEGIN
    PRINT 'Failed to delete user.';
END

-- Show remaining users
PRINT '';
PRINT 'Remaining users:';
SELECT id, email, full_name, role, active FROM dbo.Users ORDER BY id;
