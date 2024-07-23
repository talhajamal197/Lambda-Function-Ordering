import json
import boto3
import os
import logging

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def lambda_handler(event, context):
    try :
        LOGGER.info('Event: %s', event)
        
        LOGGER.info(event.get('body'))
        
        # event body is of type string, event is object        
        event_body = event.get('body',{})
        
        # Handle invalid responses        
        if not event_body:
            response = {
                'statusCode':400,
                'body':'please provide valid order_id'
            }
            return response

        # convert to python object
        event_body=json.loads(event_body)
        
        # Extract the order ID from the incoming payload
        order_id = event_body.get('id')
        
        # Processing the received order
        LOGGER.info('Received order with ID: %s', order_id)
        
        # SQS prefers stringified/json payload.
        res_body = json.dumps({
                "order_id": order_id,
                "message": "Order id successfully processed"
        })
        
        # Creating a response indicating the order id
        response = {
            "statusCode": 200,
            "body" : res_body
        }
        
        # Sending the response to an SQS queue
        client = boto3.client('sqs')
        queue_url = os.environ['QUEUE_URL']
        client.send_message(
            QueueUrl=queue_url,
            MessageBody=res_body
        )
        
        return response
    except Exception as e:
        LOGGER.error(f"An error occurred: {e}")
        raise e