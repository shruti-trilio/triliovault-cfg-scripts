[loggers]
keys = root,dmapi

[handlers]
keys = dmapi,stdout,stderr,null

[formatters]
keys = default,advanced,default-utc,advanced-utc

[logger_root]
level = INFO
handlers = null

[logger_dmapi]
level = INFO
handlers = dmapi
qualname = dmapi

[handler_dmapi]
class = logging.handlers.RotatingFileHandler
args = ('/var/log/triliovault/triliovault-datamover-api.log','a',25000000,20)
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
class = dmapi.common.log.UTCFormatter
format = %(asctime)s - %(name)s - %(levelname)s - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z

[formatter_advanced-utc]
class = dmapi.common.log.UTCFormatter
format =  %(asctime)s - %(name)s - %(levelname)s - PID:%(process)d - TID:%(thread)d - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z

[formatter_default]
format = %(asctime)s - %(name)s - %(levelname)s - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z

[formatter_advanced]
format =  %(asctime)s - %(name)s - %(levelname)s - PID:%(process)d - TID:%(thread)d - %(message)s
datefmt = %Y-%m-%d %H:%M:%S,%s %Z