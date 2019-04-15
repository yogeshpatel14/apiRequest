# apiRequest
This is helper class for api request in swift

Ex:
let request:ApiRequest = ApiRequest.initApiRequestWith(urlPart: 'login', apiRequestDelegate:self, requestMethod:POST);<br />
request.setParameterWith('userName','username') //(value,key)<br />
request.setParameterWith('password','password') //(value,key)<br />
request.startRequest();<br />

//Delegate<br />
func didRequestSuccessfullyWith(_ request:ApiRequest) {<br />
    if(request.tagURLPart == 'login') {<br />
            //code<br />
    }<br />
}<br />
<br />
<br />

func didRequestFailWith(_ request:ApiRequest, error errorMessage:Error) {<br />
        //error<br />
}<br />
