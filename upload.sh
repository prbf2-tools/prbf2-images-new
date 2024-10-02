#!/bin/bash

# PUT https://gitea.example.com/api/packages/{owner}/generic/{package_name}/{package_version}/{file_name}
# file: prbf2_1.8.0.0_server.zip

GITEA_URL=gitea.svc.local
OWNER=sboon
PACKAGE_NAME=prbf2
PACKAGE_VERSION=1.8.0.0
FILE_NAME=prbf2_1.8.0.0_server.zip

curl -k -X PUT https://$GITEA_URL/api/packages/$OWNER/generic/$PACKAGE_NAME/$PACKAGE_VERSION/$FILE_NAME \
  --upload-file $FILE_NAME \
  --user $GITEA_USER:$GITEA_PASS
