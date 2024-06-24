#!/bin/bash

# Variables
LAMBDA_FUNCTION_NAME="node-backend"
RDS_INSTANCE_ID="mysql-id"
EMAIL="kennedychukwukauche@gmail.com"

# Create SNS Topic
SNS_TOPIC_ARN=$(aws sns create-topic --name CloudWatchAlarmsTopic --query 'TopicArn' --output text)

# Subscribe to SNS Topic
aws sns subscribe --topic-arn "$SNS_TOPIC_ARN" --protocol email --notification-endpoint "$EMAIL"

# Create CloudWatch Alarm for Lambda Errors
aws cloudwatch put-metric-alarm --alarm-name LambdaErrorAlarm \
  --alarm-description "Alarm for Lambda function errors" \
  --metric-name Errors \
  --namespace AWS/Lambda \
  --statistic Sum \
  --dimensions Name=FunctionName,Value="$LAMBDA_FUNCTION_NAME" \
  --period 60 \
  --evaluation-periods 1 \
  --threshold 1 \
  --comparison-operator GreaterThanOrEqualToThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for Lambda Latency
aws cloudwatch put-metric-alarm --alarm-name LambdaLatencyAlarm \
  --alarm-description "Alarm for Lambda function latency" \
  --metric-name Duration \
  --namespace AWS/Lambda \
  --statistic Average \
  --dimensions Name=FunctionName,Value="$LAMBDA_FUNCTION_NAME" \
  --period 60 \
  --evaluation-periods 1 \
  --threshold 1000 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for Lambda Invocations
aws cloudwatch put-metric-alarm --alarm-name LambdaInvocationAlarm \
  --alarm-description "Alarm for Lambda function invocations" \
  --metric-name Invocations \
  --namespace AWS/Lambda \
  --statistic Sum \
  --dimensions Name=FunctionName,Value="$LAMBDA_FUNCTION_NAME" \
  --period 60 \
  --evaluation-periods 1 \
  --threshold 1000 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for Lambda Throttles
aws cloudwatch put-metric-alarm --alarm-name LambdaThrottleAlarm \
  --alarm-description "Alarm for Lambda function throttles" \
  --metric-name Throttles \
  --namespace AWS/Lambda \
  --statistic Sum \
  --dimensions Name=FunctionName,Value="$LAMBDA_FUNCTION_NAME" \
  --period 60 \
  --evaluation-periods 1 \
  --threshold 1 \
  --comparison-operator GreaterThanOrEqualToThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS CPU Utilization
aws cloudwatch put-metric-alarm --alarm-name RDSCpuUtilizationAlarm \
  --alarm-description "Alarm for RDS CPU Utilization" \
  --metric-name CPUUtilization \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS Freeable Memory
aws cloudwatch put-metric-alarm --alarm-name RDSFreeableMemoryAlarm \
  --alarm-description "Alarm for RDS Freeable Memory" \
  --metric-name FreeableMemory \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 1000000000 \
  --comparison-operator LessThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS Disk Queue Depth
aws cloudwatch put-metric-alarm --alarm-name RDSDiskQueueDepthAlarm \
  --alarm-description "Alarm for RDS Disk Queue Depth" \
  --metric-name DiskQueueDepth \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 5 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS Read IOPS
aws cloudwatch put-metric-alarm --alarm-name RDSReadIOPSAlarm \
  --alarm-description "Alarm for RDS Read IOPS" \
  --metric-name ReadIOPS \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 1000 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS Write IOPS
aws cloudwatch put-metric-alarm --alarm-name RDSWriteIOPSAlarm \
  --alarm-description "Alarm for RDS Write IOPS" \
  --metric-name WriteIOPS \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 1000 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS Read Latency
aws cloudwatch put-metric-alarm --alarm-name RDSReadLatencyAlarm \
  --alarm-description "Alarm for RDS Read Latency" \
  --metric-name ReadLatency \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 0.1 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"

# Create CloudWatch Alarm for RDS Write Latency
aws cloudwatch put-metric-alarm --alarm-name RDSWriteLatencyAlarm \
  --alarm-description "Alarm for RDS Write Latency" \
  --metric-name WriteLatency \
  --namespace AWS/RDS \
  --statistic Average \
  --dimensions Name=DBInstanceIdentifier,Value="$RDS_INSTANCE_ID" \
  --period 300 \
  --evaluation-periods 1 \
  --threshold 0.1 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions "$SNS_TOPIC_ARN"