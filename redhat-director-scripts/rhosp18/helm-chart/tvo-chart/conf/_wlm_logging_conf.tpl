[loggers]
keys = root, workloadmgr-api, workloadmgr-workloads, workloadmgr-cron, workloadmgr-scheduler

[handlers]
keys = stdout,stderr,null, workloadmgr-api, workloadmgr-workloads, workloadmgr-scheduler, workloadmgr-cron

[formatters]
keys = default,advanced,default-utc,advanced-utc

[logger_root]
level = INFO
handlers = null

[logger_workloadmgr-cron]
level = INFO
handlers = workloadmgr-cron,stdout,stderr
qualname = workloadmgr-cron

[logger_workloadmgr-scheduler]
level = INFO
handlers = workloadmgr-scheduler,stdout,stderr
qualname = workloadmgr-scheduler

[logger_workloadmgr-workloads]
level = INFO
handlers = workloadmgr-workloads,stdout,stderr
qualname = workloadmgr-workloads

[logger_workloadmgr-api]
level = INFO
handlers = workloadmgr-api,stdout,stderr
qualname = workloadmgr-api

[handler_workloadmgr-api]
class = workloadmgr.concurrent_log_handler.ConcurrentRotatingFileHandler
args = ('/var/log/triliovault/triliovault-wlm-api.log','a', 25000000,20)
formatter = advanced-utc

[handler_workloadmgr-cron]
class = workloadmgr.concurrent_log_handler.ConcurrentRotatingFileHandler
args = ('/var/log/triliovault/triliovault-wlm-cron.log','a', 25000000,20)
formatter = advanced-utc

[handler_workloadmgr-scheduler]
class = workloadmgr.concurrent_log_handler.ConcurrentRotatingFileHandler
args = ('/var/log/triliovault/triliovault-wlm-scheduler.log','a', 25000000,20)
formatter = advanced-utc

[handler_workloadmgr-workloads]
class = workloadmgr.concurrent_log_handler.ConcurrentRotatingFileHandler
args = ('/var/log/triliovault/triliovault-wlm-workloads.log','a', 25000000,20)
formatter = advanced-utc

[handler_stderr]
class = StreamHandler
args = (sys.stderr,)
formatter = default

[handler_stdout]
class = StreamHandler
args = (sys.stdout,)
formatter = advanced

[handler_null]
class = NullHandler
formatter = default
args = ()

[formatter_default-utc]
class = workloadmgr.openstack.common.log.UTCFormatter
format = %(asctime)s - %(name)s - %(levelname)s - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z

[formatter_advanced-utc]
class = workloadmgr.openstack.common.log.UTCFormatter
format =  %(asctime)s - %(name)s - %(levelname)s - PID:%(process)d - TID:%(thread)d - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z

[formatter_default]
format = %(asctime)s - %(name)s - %(levelname)s - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z

[formatter_advanced]
format =  %(asctime)s - %(name)s - %(levelname)s - PID:%(process)d - TID:%(thread)d - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z
