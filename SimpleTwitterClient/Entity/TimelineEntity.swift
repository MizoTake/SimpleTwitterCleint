//
//  TimelineEntity.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit

final class TimelineEntity: NSObject {
    
    private(set) var userName = ""
    
    private(set) var tweetText = ""
    
    func register(tweetText: String, userName: String) {
        self.tweetText = tweetText
        self.userName = userName
    }
    
}
