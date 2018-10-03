//
//  StatusCodeError.swift
//  OyeMiRadio
//
//  Created by Patel Yogesh on 20/09/18.
//  Copyright © 2018 mycom. All rights reserved.
//

import UIKit

class StatusCodeError: NSObject {
    class func getErrorWith(statusCode:NSInteger) -> NSError {
        var error:NSError!
        if(statusCode == 401) {
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Access is denied" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
            
        }
        else if(statusCode == 400) {
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Bad request" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
        }
        else if(statusCode == 404) {
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"URL not found" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
        }
        else if(statusCode == 500) {
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Internal server error" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
        }
        else if(statusCode == 502) {
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Bad gateway" ,forKey:"error" as NSCopying) as! [AnyHashable: Any] as! [String : Any]) )
        }
        else if(statusCode == 503) {
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Service unavailable" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
            
        }
        else {
            /**
             *status code is not equal to 200 then this block is execute
             */
            error = NSError.init(domain: "error", code: 0, userInfo: (NSDictionary(object:"Something went wrong" ,forKey:"error" as NSCopying) as? [AnyHashable: Any] as! [String : Any]) )
            
        }
        return error;
    }
}
