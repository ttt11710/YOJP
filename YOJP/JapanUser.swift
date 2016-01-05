//
//  JapanUser.swift
//  YOJP
//
//  Created by PayBay on 16/1/5.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class JapanUser: NSObject,NSCoding {

    
    var userId : String = ""
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userId, forKey: "userId")
    }

    
    init(userId : String) {
        self.userId = userId
    }
    
    required init(coder aDecoder: NSCoder) {
        userId  = (aDecoder.decodeObjectForKey("userId") ?? "") as! String
    }
}


struct CurrentUser {
    static var user : JapanUser? {
        set {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(newValue, forKey: "JapanUser")
        archiver.finishEncoding()
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: "JapanUser")
        NSUserDefaults.standardUserDefaults().synchronize()
        }
        get {
            let data = NSUserDefaults.standardUserDefaults().valueForKey("JapanUser") as! NSData?
            if let userData = data {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: userData)
                return unarchiver.decodeObjectForKey("JapanUser") as? JapanUser
            }
            else {
                return nil
            }
        }
    }
}
