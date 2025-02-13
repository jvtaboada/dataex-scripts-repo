SELECT  
    plan.name AS MaintenancePlan,  
    log.start_time,  
    log.end_time,  
    log.succeeded  
FROM msdb.dbo.sysmaintplan_log log  
JOIN msdb.dbo.sysmaintplan_plans plan ON log.plan_id = plan.id  
ORDER BY log.start_time DESC;
