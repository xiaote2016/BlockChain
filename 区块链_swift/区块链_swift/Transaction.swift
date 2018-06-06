//
//  Transaction.swift
//  区块链_swift
//
//  Created by 小特 on 2018/6/5.
//  Copyright © 2018年 xiete. All rights reserved.
//

import UIKit
import ObjectMapper

class Transaction: Mappable {
    init(fromAddress : String?, toAddress : String, amount : String){
        self.fromAddress = fromAddress
        self.toAddress = toAddress
        self.amount = amount
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        fromAddress <- map["fromAddress"]
        toAddress   <- map["toAddress"]
        amount      <- map["amount"]
    }
    
    
    var fromAddress : String?
    
    var toAddress : String?
    
    var amount : String?
    
}
