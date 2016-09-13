//
//  TimelineEntity.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit

final class TimelineEntity: NSObject {
    
    var tweetText = ""
    
    func register(tweetText: String) {
        self.tweetText = tweetText
    }
    
}
