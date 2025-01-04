import json
import boto3

def lambda_handler(event, context):
    sfn = boto3.client('stepfunctions')
    sfn.start_execution(
        input = event["input"],
        stateMachineArn = "arn:aws:iam::422057007813:role/step_functions_role" #replace with your state machine ARN
    )