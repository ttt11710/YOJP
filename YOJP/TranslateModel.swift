//
//  TranslateModel.swift
//  YOJP
//
//  Created by PayBay on 15/11/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import SwiftyJSON

class TransResult : NSObject {
    var src : String?
    var dst : String?
    
    init(json : JSON) {
        src = json["src"].stringValue ?? "翻译原文"
        dst = json["dst"].stringValue ?? "翻译结果"
    }
    
    class func transResult(json:JSON) -> [TransResult] {
        
        return json["trans_result"].arrayValue.map{TransResult(json: $0)}
    }
}


class TranslateModel: NSObject {

    var from : String?
    var to : String?
    var trans_result : [TransResult]
    
    init(json : JSON) {
        
        from = json["from"].stringValue ?? "语言"
        to = json["to"].stringValue ?? "语言"
        trans_result = TransResult.transResult(json)
    }
    
    
}
