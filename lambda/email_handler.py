import json
import boto3

def lambda_handler(event, context):
    ses = boto3.client("ses")

    ses.send_email(
        Source = "sanisherif838@gmail.com",
        Destination = {
            'ToAddresses' : [
                event['destinationEmail']
            ]
        },
        Message = {
            'Subject': {
                'Data': 'Hello from my project',
            },
            'Body': {
                'Text': {
                    'Data': event['message'],
                },
            }
        }
    )
    return {
        "status": 200,
        "body": "Email successfully sent"
    }