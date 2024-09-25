#!/bin/bash

set -ex
source /tmp/triliovault-cloudrc
## Keystone Resources Creation
USER_NAME="{{- .Values.keystone.datamover_api.user -}}"
PASSWORD="{{- .Values.keystone.datamover_api.password -}}"
SERVICE_DOMAIN="{{- .Values.keystone.common.service_project_domain_name -}}"
SERVICE_PROJECT="{{- .Values.keystone.common.service_project_name -}}"
ADMIN_ROLE_NAME="{{- .Values.keystone.common.admin_role_name -}}"
SERVICE_NAME="{{- .Values.keystone.datamover_api.service_name -}}"
## Create keystone user if it does not exists
if openstack user list --domain $SERVICE_DOMAIN -f value -c Name | grep -qw $USER_NAME; then
  echo "User $USER_NAME already exists in domain $SERVICE_DOMAIN."
else
  openstack user create --domain $SERVICE_DOMAIN --password $PASSWORD $USER_NAME
fi
openstack role add --project $SERVICE_PROJECT --user $USER_NAME $ADMIN_ROLE_NAME

# Create keystone service if it does not exists
if openstack service list -f value -c Name | grep -qw $SERVICE_NAME; then
  echo "Service $SERVICE_NAME already exists."
else
  # Create the service if it does not exist
  openstack service create --name $SERVICE_NAME --description "{{- .Values.keystone.datamover_api.service_desc -}}" "{{- .Values.keystone.datamover_api.service_type -}}"
  openstack endpoint create --region "{{- .Values.keystone.common.region_name -}}"  $SERVICE_NAME public "{{- .Values.keystone.datamover_api.public_endpoint -}}"
  openstack endpoint create --region "{{- .Values.keystone.common.region_name -}}" $SERVICE_NAME internal "{{- .Values.keystone.datamover_api.internal_endpoint -}}"
  openstack endpoint create --region "{{- .Values.keystone.common.region_name -}}" $SERVICE_NAME admin "{{- .Values.keystone.datamover_api.admin_endpoint -}}"

  echo "Service $SERVICE_NAME and its endpoints have been created."
fi
