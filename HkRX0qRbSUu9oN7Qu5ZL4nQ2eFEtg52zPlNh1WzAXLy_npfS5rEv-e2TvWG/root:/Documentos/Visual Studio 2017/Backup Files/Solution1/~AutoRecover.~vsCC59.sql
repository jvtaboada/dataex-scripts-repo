SELECT 
    name AS DatabaseName,
    state_desc AS Status,
    recovery_model_desc AS RecoveryModel,
    user_access_desc AS UserAccess,
    is_read_only,
    is_auto_close_on,
    is_auto_shrink_on
FROM 
    sys.databases
ORDER BY 
    name;
