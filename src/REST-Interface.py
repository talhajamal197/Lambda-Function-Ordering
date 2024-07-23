import requests

def send_post_request():
    endpoint = "https://your-api-url.execute-api.eu-central-1.amazonaws.com/devl/add_order-devl"
        
    # Message body as a Python dictionary
    message_body = {
        "id": "1722"
    }
    
    try:
        # Sending a POST request to the endpoint with the message body
        response = requests.post(endpoint, json=message_body)

        # Checking the response status
        if response.status_code == 200:
            print("POST request successful!")
            print("Response:", response.json())
        else:
            print(f"POST request failed with status code {response.status_code}")
            print("Response:", response.text)
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    send_post_request()