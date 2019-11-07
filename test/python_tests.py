import requests

votingapp_host=sys.argv[1]

URL = "http://"+votingapp_host+"/vote"
params_Post = {'topics':['dev', 'ops']} 
headers = {'content-type': 'application/json'}
#headers = {'Content-Type': 'application/json'}

r_post = requests.post(URL, data=json.dumps(params_Post), headers=headers)

params_Put = {'topic':'dev'} 
#headers = {'Content-Type': 'application/json'}

r_put = requests.put(URL, data=json.dumps(params_Put), headers=headers)


r_delete = requests.delete(URL,headers=headers)

