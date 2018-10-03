//
//  ApiRequest.swift
//  OyeMiRadio
//
//  Created by Patel Yogesh on 20/09/18.
//  Copyright © 2018 mycom. All rights reserved.
//

import UIKit
import Foundation
/**
 * declare time out request
 */
let TIME_OUT = 60

/**
 * Request Method
 */
enum RequestMethod:Int {
    case GET = 0
    case POST = 1
    case PUT = 2
}

class ApiRequest: NSObject {
    //MARK: - variable declaration
    var apiRequestDelegate:ApiRequestDelegate!;
    var tagURLPart:String! = "";
    var requestMethod:RequestMethod!
    var requestUrl:String! = "";
    var response : [String:Any] = [:];
    var statusCode:NSInteger!
    var responseData:NSMutableData!
    var request:URLRequest!;
    var parameter:NSMutableDictionary! = NSMutableDictionary();
    
    //MARK: - init api request class
    class func initApiRequestWith(urlPart url_part:String, apiRequestDelegate delegate:ApiRequestDelegate, requestMethod reqMethod:RequestMethod) -> ApiRequest {
        let apiRequest = ApiRequest.init();
        apiRequest.requestUrl = String(format: "%@/%@",URL_LIST.BASE_URL,url_part);
        apiRequest.tagURLPart = url_part;
        apiRequest.apiRequestDelegate = delegate;
        apiRequest.requestMethod = reqMethod;
        apiRequest.parameter = NSMutableDictionary.init();
        return apiRequest;
    }
    
    public func setParameterWith(value:AnyObject, key:String) {
        self.parameter.setValue(value, forKey: key)
    }
    
    //MARK: - start request
    public func startRequest() {
        let param:String = ApiRequestUtil.getQueryParameter(self.parameter)
        if(requestMethod == RequestMethod.GET) {
            self.getRequest(param: param)
        }
        else if(requestMethod == RequestMethod.POST) {
            self.postRequest(param: param)
        }
        else if(requestMethod == RequestMethod.PUT) {
            self.putRequest(param: param)
        }
        self.startUrlDataTask();
    }
    
    private func getRequest(param:String) {
        var strUrl:String;
        if(param.count <= 0) {
            strUrl = self.requestUrl;
        }
        else {
            strUrl = String(format:"%@?%@",self.requestUrl,param)
        }
        self.createRequest(strUrl: strUrl, reqMethod: "GET")
    }
    
    private func postRequest(param:String) {
        self.createRequest(strUrl: self.requestUrl, reqMethod: "POST")
        self.request.httpBody = param.data(using: String.Encoding.utf8)
    }
    
    private func putRequest(param:String) {
        self.createRequest(strUrl: self.requestUrl, reqMethod: "PUT")
        self.request.httpBody = param.data(using: String.Encoding.utf8)
    }
    
    private func createRequest(strUrl:String, reqMethod:String) {
        self.request = ApiRequestUtil.createUrlRequest(strUrl: strUrl, reqMethod: reqMethod)
    }
    
    //MARK: - session url task
    private func startUrlDataTask() {
        ApiRequestTask.startRequestTaskWith(request: self.request, apiRequestTaskDelegate: self);
    }
    
    // MARK: - User define method
    
    func requestSuccess() {
        /**
         *encounter delegate method requestDidSuccessfully
         */
        self.apiRequestDelegate.didRequestSuccessfullyWith(self);
    }
    
    func requestFailWithError(_ error:Error) {
        /**
         *encounter delegate method requestDidFail with error
         */
        self.apiRequestDelegate.didRequestFailWith(self, error: error)
    }
}

extension ApiRequest:ApiRequestTaskDelegate {
    func didRequestTaskSuccessfullyWith(data: Data, responseData: Any) {
        self.responseData = NSMutableData.init();
        let _response:HTTPURLResponse = responseData as! HTTPURLResponse;
        self.statusCode = _response.statusCode as NSInteger;
        if !data.isEmpty {
            /**
             *append data with responseData
             */
            self.responseData.append(data);
            let newStr = NSString.init(data: self.responseData! as Data, encoding:String.Encoding.utf8.rawValue)
            print("\(newStr ?? "")")
            
            
            //parse data
            do {
                let parsedData = try JSONSerialization.jsonObject(with: self.responseData! as Data, options: []) as! [String:Any]
                self.response = parsedData;
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            /**
             *call requestSuccess method
             */
            self.requestSuccess();
        }
        else{
            /**
             *if data is nil
             */
            let error:NSError = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Something went wrong" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
            /**
             *call requestFailWithError Method
             */
            self.requestFailWithError(error);
        }
    }
    
    func didRequestTaskFailWith(responseData: Any, error: Error) {
        self.requestFailWithError(error);
    }

}


