//
//  ViewController.swift
//  区块链_swift
//
//  Created by 小特 on 2018/6/5.
//  Copyright © 2018年 xiete. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blockChain = BlockChainClass.init()
        
        print("创建一些交易")
        blockChain.createTransaction(transaction: Transaction.init(fromAddress: "address1", toAddress: "address2", amount: "100"))
        blockChain.createTransaction(transaction: Transaction.init(fromAddress: "address2", toAddress: "address1", amount: "50"))
        
        print("开始挖")
        
        blockChain.minePendingTransactions(miningRewardAddress: "xiete-address")
        
        
        print("谢特的余额:\(blockChain.getBalanceOfAddress(adress: "xiete-address"))")
        
        // 我们的代码逻辑是挖矿结束后清空待处理交易数组,并且给旷工奖励,给的奖励也是个交易,这个交易是加在区块链中待处理交易的数组中,只有下次挖矿才会被记录到区块链中
        
        blockChain.minePendingTransactions(miningRewardAddress: "xiete-address")
         print("谢特的余额:\(blockChain.getBalanceOfAddress(adress: "xiete-address"))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

