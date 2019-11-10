import requests
from retry import retry 
import sys

@retry(Exception, tries=3, delay=5)
def make_test():
    print('Tests Starting ... ')
    URL = "http://localhost/vote"
    params_Post = {'topics':['dev', 'ops']} 
    headers = {'Content-Type': 'application/json'}
    try:
        r_post = requests.post(URL, params=params_Post, headers=headers)
        params_Put = {'topic':'dev'} 
        r_put = requests.put(URL, params=params_Put, headers=headers)
        header_delete = []
        r_delete = requests.delete(URL,headers=headers)
        data = r_delete.json() 
        print(data)
        winner = data['winner']
        expectedWinner = "dev"
        if winner == expectedWinner:
            print("TEST PASSED")
        else:
            print("TEST FAILED")
            raise Exception("TEST FAILED")
    except requests.exceptions.RequestException as e:  # This is the correct syntax
        print("TEST FAILED")
        raise Exception("TEST FAILED")

make_test()