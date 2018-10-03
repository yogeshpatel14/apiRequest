//
//  ApiRequestUtil.swift
//  OyeMiRadio
//
//  Created by Patel Yogesh on 20/09/18.
//  Copyright © 2018 mycom. All rights reserved.
//

import UIKit

class ApiRequestUtil: NSObject {
    class func getQueryParameter(_ parameter:NSMutableDictionary) -> String {
        var strQueryParameter:String = "";
        if(parameter.count != 0) {
            let key = parameter.allKeys as NSArray;
            let listParam:NSMutableArray = NSMutableArray();
            for i:NSInteger in 0..<key.count {
                let temp = NSString(format:"%@=%@",key.object(at: i) as! String,parameter.object(forKey: key.object(at: i)) as! String);
                listParam.add(temp);
            }
            
            strQueryParameter = listParam.componentsJoined(by: "&");
        }
        return strQueryParameter;
    }
    
    class func getJsonString(_ parameter:NSMutableDictionary) -> String {
        var strJsonData = "";
        do {
             let jsonData = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            strJsonData = String(data: jsonData, encoding: .utf8)!
            }
         catch {
            print(error.localizedDescription)
        }
     return strJsonData;
    }
    
    class func createUrlRequest(strUrl:String, reqMethod:String) -> URLRequest {
        let url:URL = URL(string: strUrl)!;
        var request:URLRequest = URLRequest.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(TIME_OUT));
        request.httpMethod = reqMethod;
        
        /**
         * declare http header field according your request
         */
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return request;
    }
    
    
}
