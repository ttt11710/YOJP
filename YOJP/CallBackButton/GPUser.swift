//
//  GPUser.swift
//  swiftShrb
//
//  Created by PayBay on 15/10/8.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import SwiftyJSON

class GPUser: NSObject,NSCoding {
    
    var userId : String = ""
    var userName : String = ""
    var alias : String = ""
    var token : String = ""
    var phone : String = ""
    
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userId, forKey: "userId")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(alias, forKey: "alias")
        aCoder.encodeObject(token, forKey: "token")
        aCoder.encodeObject(phone, forKey: "phone")
    }
    
    init(json : JSON) {
        userId = json["userId"].stringValue
        userName = json["userName"].stringValue
        alias = json["alias"].stringValue
        token = json["token"].stringValue
        phone = json["phone"].stringValue
    }
    
    required init(coder aDecoder: NSCoder) {
        userId  = (aDecoder.decodeObjectForKey("userId") ?? "") as! String
        userName  = (aDecoder.decodeObjectForKey("userName") ?? "") as! String
        alias = (aDecoder.decodeObjectForKey("alias") ?? "") as! String
        token = (aDecoder.decodeObjectForKey("token") ?? "")as! String
        phone = (aDecoder.decodeObjectForKey("phone") ?? "")as! String
    }
    
}

struct CurrentUser {
    static var user : GPUser? {
        set {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(newValue, forKey: "GPUser")
        archiver.finishEncoding()
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: "GPUser")
        NSUserDefaults.standardUserDefaults().synchronize()
        }
        get {
            let data = NSUserDefaults.standardUserDefaults().valueForKey("GPUser") as! NSData?
            if let userData = data {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: userData)
                return unarchiver.decodeObjectForKey("GPUser") as? GPUser
            }
            else {
                return nil
            }
        }
    }
}































