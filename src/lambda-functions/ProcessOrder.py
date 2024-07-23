import json
import logging

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def process_order(order_id):
    # Process the order
    print(f"Order-id: {order_id} has been processed.")

def lambda_handler(event, context):

    LOGGER.info('SQS Event: %s', event)
    
    first_record = event.get('Records',[])[0]
    event_body = json.loads(first_record.get('body',{})) # get method returns 'None' if no msg is found.
    
    process_order(event_body.get('order_id'))
    
    return {
        'statusCode': 200,
        'body': 'SQS messages processed successfully'
    }
