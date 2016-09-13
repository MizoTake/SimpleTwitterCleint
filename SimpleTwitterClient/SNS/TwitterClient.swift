//
//  TwitterClient.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/12.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Accounts
import Social

final class TwitterClient: NSObject {
    
    private let alert = AlertDialog()
    
    private var accountStore = ACAccountStore()
    
    static var myAccount = Variable<ACAccount?>(nil)
    
    func setup() {
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted:Bool, error:NSError?) -> Void in
            
            if error != nil {
                self.alert.showAlert("Error", alertMessage: "\(error)", buttonTitle: ["OK"], buttonAction: [{self.alert.openSetting()}])
                return
            }
            
            if !granted {
                self.alert.showAlert("Error", alertMessage: "TwitterAccountの許可がありません", buttonTitle: ["OK"], buttonAction: [{self.alert.openSetting()}])
                return
            }
            
            let accounts = self.accountStore.accountsWithAccountType(accountType) as! [ACAccount]
            if accounts.count == 0 {
                self.alert.showAlert("Error", alertMessage: "設定画面からアカウントを設定してください", buttonTitle: ["OK"], buttonAction: [{self.alert.openSetting()}])
                return
            }
            
            self.selectAccount(accounts)
        }
    }
    
    private func selectAccount(accounts: [ACAccount]) {
        let accountNames = accountnames(accounts)
        var action = [{TwitterClient.myAccount.value = accounts[$0]}]
        for _ in 0..<accountNames.count - 1 {
            action += action
        }
        alert.showAlertSheet("Twitter", alertMessage: "アカウントを選択してください", selectionTitle: accountNames, selectionAction: action)
    }
    
    
    private func accountnames(accounts: [ACAccount]) -> [String] {
        var result = [String]()
        for account in accounts {
            result.append(account.username)
        }
        return result
    }
    
}
