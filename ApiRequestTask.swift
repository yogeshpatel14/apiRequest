//
//  ApiRequestTask.swift
//  OyeMiRadio
//
//  Created by Patel Yogesh on 20/09/18.
//  Copyright © 2018 mycom. All rights reserved.
//

import UIKit

protocol ApiRequestTaskDelegate {
    func didRequestTaskSuccessfullyWith(data:Data,responseData:Any);
    func didRequestTaskFailWith(responseData:Any,error:Error);
}

class ApiRequestTask: NSObject {
    class func startRequestTaskWith(request:URLRequest,apiRequestTaskDelegate delegate:ApiRequestTaskDelegate) {
        /**
         *pass request to NSURLSession
         */
        
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default;
        let session:URLSession = URLSession(configuration: configuration,delegate: nil,delegateQueue:nil);
        
        let dataTask:URLSessionDataTask = session.dataTask(with: request as URLRequest,completionHandler: { (data,response,error) in
            if(error == nil){
                delegate.didRequestTaskSuccessfullyWith(data: data!, responseData: response as Any)
                let _response:HTTPURLResponse = response as! HTTPURLResponse;
                let statusCode:NSInteger = _response.statusCode as NSInteger;
                if(statusCode != 200) {
                    delegate.didRequestTaskFailWith(responseData: response as Any, error:StatusCodeError.getErrorWith(statusCode: statusCode))
                }
                else {
                    delegate.didRequestTaskSuccessfullyWith(data: data!, responseData: response as Any)
                }
            }
            else {
                delegate.didRequestTaskFailWith(responseData: response as Any, error: error!)
            }
        });
        dataTask.resume();
    }
    
}
