import json
import boto3

def lambda_handler(event, context):
    sfn = boto3.client('stepfunctions')
    
    sfn.start_execution(
        input = event["input"],
        stateMachineArn = "arn:aws:states:us-east-1:422057007813:stateMachine:notificationStateMachine" #replace with your state machine ARN
    )