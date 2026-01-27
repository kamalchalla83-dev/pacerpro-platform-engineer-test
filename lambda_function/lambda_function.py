import boto3
import os
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client('ec2')
sns = boto3.client('sns')

INSTANCE_ID = os.environ['INSTANCE_ID']
SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    logger.info(f"Received alert event: {event}")

    ec2.reboot_instances(InstanceIds=[INSTANCE_ID])

    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Subject="Auto Remediation Triggered",
        Message=f"EC2 instance {INSTANCE_ID} rebooted due to API latency."
    )

    return {"status": "success"}

