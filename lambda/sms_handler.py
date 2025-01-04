import json
import boto3

def lambda_handler(event, context):
    sns = boto3.client("sns")

    sns.publish(
        PhoneNumber = event["phoneNumber"],
        Message = event["message"],
    )
    return {
        "status" : 200,
        "body": "SMS sent!"
    }
