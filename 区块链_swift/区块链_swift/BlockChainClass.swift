//
//  BlockChainClass.swift
//  区块链_swift
//
//  Created by 小特 on 2018/6/5.
//  Copyright © 2018年 xiete. All rights reserved.
//

import UIKit

class BlockChainClass: NSObject {
    
    lazy var chain : [BlockClass] = [creatGenesisBlock()]
    
    /// 难度
    let difficulty = 4
    
    // 待处理交易
    var pendingTransactions : [Transaction]?
    
    let miningReward = 100
    
    private func creatGenesisBlock() -> BlockClass{
        return BlockClass.init(timestamp: "2018-01-01", transactions: nil,previousHash: "0")
    }
    
    
    /// 添加交易
    func createTransaction(transaction : Transaction){
        // 校验
        
        self.pendingTransactions?.append(transaction)
    }
    
    /// 挖矿
    func minePendingTransactions(miningRewardAddress : String){
        
        // 用所有待交易来创建新的区块并且开挖..
        let block = BlockClass(timestamp: dateNowAsString(), transactions: self.pendingTransactions,previousHash: self.chain.last?.currentHash ?? "0")
        
        block.mineBlock(difficulty: difficulty)
        
        print("MINED  Block : \(block.currentHash!) \n 根据难度寻找合适的hash的次数: \(block.nonce)")
        self.chain.append(block)
        
        // 重置待处理交易列表并且发送奖励
        self.pendingTransactions = [Transaction.init(fromAddress: nil, toAddress: miningRewardAddress, amount: "\(miningReward)")]
    }
    
    // 获取余额
    func getBalanceOfAddress(adress : String) -> Double{
        
        var balance = 0.0
        
        for block in self.chain{
            if let transactions = block.transactions{
                for trans in transactions{
                    
                    // 减少余额
                    if (trans.fromAddress == adress){
                        balance -= Double(trans.amount!)!
                    }
                    
                    // 增加金额
                    if(trans.toAddress == adress){
                        balance += Double(trans.amount!)!
                    }
                    
                }
            }
            
        }
        return balance
    }

}

extension BlockChainClass{
    func dateNowAsString() -> String {
        
        let nowDate = Date()
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: nowDate)
        return date.components(separatedBy: " ").first!
    }
}
