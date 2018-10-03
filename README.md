# apiRequest
This is helper class for api request in swift

Ex:
let request:ApiRequest = ApiRequest.initApiRequestWith(urlPart: 'login', apiRequestDelegate:self, requestMethod:POST);
request.setParameterWith('userName','username') //(value,key)
request.setParameterWith('password','password') //(value,key)
request.startRequest();

//Delegate
func didRequestSuccessfullyWith(_ request:ApiRequest) {
    if(request.tagURLPart == 'login') {
            //code
    }
}

func didRequestFailWith(_ request:ApiRequest, error errorMessage:Error) {
        //error
}
