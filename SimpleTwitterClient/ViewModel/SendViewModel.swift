//
//  SendViewModel.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import Accounts

class SendViewModel: NSObject {
    
    let postTweet = TwitterPostRequest()
    
    func post(tweet: String) {
        postTweet.request(TwitterClient.myAccount.value!, tweet: tweet)
    }
    
}
