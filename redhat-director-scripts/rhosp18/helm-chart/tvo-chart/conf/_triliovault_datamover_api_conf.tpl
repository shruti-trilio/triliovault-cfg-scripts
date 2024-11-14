[DEFAULT]
dmapi_workers = {{ .Values.common.dmapi_workers }}
transport_url = "{{ .Values.rabbitmq.datamover_api.transport_url }}"
dmapi_enabled_ssl_apis =
dmapi_listen_port = 8784
dmapi_enabled_apis = dmapi
bindir = /usr/bin
instance_name_template = instance-%08x
rootwrap_config = /etc/triliovault-datamover/rootwrap.conf
log_config_append = /etc/triliovault-datamover/datamover_api_logging.conf


[wsgi]
ssl_cert_file = 
ssl_key_file =
api_paste_config = /etc/triliovault-datamover/api-paste.ini

[database]
connection = mysql+pymysql://{{- .Values.database.datamover_api.user -}}:{{- .Values.database.datamover_api.password -}}@{{- .Values.database.common.host -}}:{{- .Values.database.common.port -}}/{{- .Values.database.datamover_api.database }}

[keystone_authtoken]
memcached_servers = {{ .Values.common.memcached_servers }}
signing_dir = /var/cache/dmapi
{{- if .Values.keystone.common.is_self_signed_ssl_cert }}
cafile = /etc/pki/tls/certs/openstack-ca-cert.pem
{{- else }}
cafile =
{{- end }}
project_domain_name = {{ .Values.keystone.common.service_project_domain_name }}
project_name = {{ .Values.keystone.common.service_project_name }}
user_domain_name = {{ .Values.keystone.common.service_project_domain_name }}
password = {{ .Values.keystone.datamover_api.password }}
username = {{ .Values.keystone.datamover_api.user }}
auth_url = {{ .Values.keystone.common.auth_url }}
auth_type = password
auth_uri = {{ .Values.keystone.common.auth_uri }}


[oslo_messaging_notifications]
transport_url = {{ .Values.rabbitmq.datamover_api.transport_url }}
driver = {{ .Values.rabbitmq.common.driver }}

[oslo_middleware]
enable_proxy_headers_parsing = {{  .Values.common.oslo_enable_proxy_headers_parsing }}
