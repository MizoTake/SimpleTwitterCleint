//
//  TwitterGetResponse.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import ObjectMapper

class TwitterGetResponse: Mappable {
    
    var tweetText: String!
    
    func mapping(map: Map) {
        tweetText <- map["text"]
    }

    required init?(_ map: Map) {
    }
    
    init() { }
    
}
