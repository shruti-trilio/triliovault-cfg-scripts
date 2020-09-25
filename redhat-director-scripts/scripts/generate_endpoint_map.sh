#!/bin/bash

set -e

if [ $# -lt 1 ];then
   echo "Script takes exacyly 2 argument"
   echo -e "./generate_endpoint_map.sh <OPENSTACK_TRIPLEO_HEAT_TEMPLATES_DIRECTORY_PATH>"
   echo -e "Examples:"
   echo -e "./generate_endpoint_map.sh /usr/share/openstack-tripleo-heat-templates/"
   exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TEMPLATES=$1
THT_ENDPOINT_DATA=$TEMPLATES/network/endpoints/endpoint_data.yaml
TRILIO_ENDPOINT_DATA=$SCRIPT_DIR/trilio_endpoint_data.yaml
OUTPUT_FILE=$SCRIPT_DIR/endpoint_map.yaml

echo "Generate endpoint map from ${THT_ENDPOINT_DATA} and ${TRILIO_ENDPOINT_DATA}"
$TEMPLATES/network/endpoints/build_endpoint_map.py \
    -i <(cat $THT_ENDPOINT_DATA $TRILIO_ENDPOINT_DATA) \
    -o $OUTPUT_FILE

echo "Generated new endpoint map file at ${OUTPUT_FILE}"
echo "Update resource 'OS::TripleO::EndpointMap' in file ../templates/trilio_env_*.yaml"