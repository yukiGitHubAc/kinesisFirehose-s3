#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# ログ設定
cur_time=$(date +%Y%m%d%H%M%S)
log_file=./log.$(basename ${0}).${cur_time}
exec 2> ${log_file}; set -xv
# ------------------------------------------------------------------------------
source ./config.ini &> /dev/null
#------------------------------------------------------------------------------
# デプロイ
 aws cloudformation deploy \
     --s3-bucket ${S3_BUCKET_NAME} \
     --template-file ../dist/kinesis-firehose-s3.package.yaml \
     --stack-name ${STACK_NAME} \
     --capabilities CAPABILITY_NAMED_IAM \
     --role-arn ${ROLE_ARN} \
     --region ${REGION}
 [ $? -ne 0 ] && exit 1
#------------------------------------------------------------------------------
rm -f ${log_file}
exit 0