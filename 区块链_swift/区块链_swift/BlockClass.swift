//
//  BlockClass.swift
//  区块链_swift
//
//  Created by 小特 on 2018/6/5.
//  Copyright © 2018年 xiete. All rights reserved.
//

import UIKit
import MJExtension
import ObjectMapper

class BlockClass: NSObject {

    /// 时间
    var timestampme : String = ""
    
    /// 上一个区块的hash
    var previousHash : String = ""
    
    /// 所有交易
    var transactions : [Transaction]?
    
    var nonce : Int = 0
    
    var currentHash : String?
    
    init(timestamp: String, transactions: [Transaction]?, previousHash : String = "") {
        
       super.init()
        self.previousHash = previousHash;
        self.timestampme = timestamp;
        self.transactions = transactions;
        self.currentHash = calculateHash()
        
        
    }
    
    private func calculateHash() -> String {
        
        var transactionsStr = "Genesis block"
        if ((self.transactions) != nil){
            
            transactionsStr = transactions!.toJSONString()!
            
        }
        return SHA256(string: (self.previousHash + self.timestampme + transactionsStr + "\(self.nonce)"))
    }
    
    func mineBlock(difficulty : Int){
        var str = ""
        for _ in 0..<difficulty {
            str = str + "0"
        }
        while currentHash?.substring(toIndex: difficulty) != str {
            nonce += 1
            currentHash = calculateHash()
        }
    }
    
    
    private func SHA256(string : String) -> String {
        let str = string.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: digestLen)
        return String(format: hash as String)
    }
}

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}

