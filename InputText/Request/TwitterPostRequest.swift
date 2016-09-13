//
//  TwitterPostRequest.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Accounts
import Social
import ObjectMapper

class TwitterPostRequest: NSObject {
    
    let alert = AlertDialog()
    
    func request(account: ACAccount, tweet: String) {
        let URL = NSURL(string: "https://api.twitter.com/1.1/statuses/update.json")
        
        let params = ["status" : tweet]
        
        // リクエストを生成
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .POST,
                                URL: URL,
                                parameters: params)
        
        request.account = account
        
        request.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
            
            if error != nil {
                self.alert.showAlert("Error", alertMessage: "\(error)", buttonTitle: ["OK"], buttonAction: [{}])
            } else {
                self.alert.showAlert("Tweet!", alertMessage: "Post Success", buttonTitle: ["OK"],
                    buttonAction: [{}])
            }
        }
    }
    
}
