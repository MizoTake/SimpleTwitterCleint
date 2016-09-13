//
//  TwitterGetResponse.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import ObjectMapper

final class TwitterGetResponse: Mappable {
    
    private(set) var userName: String!
    
    private(set) var tweetText: String!
    
    func mapping(map: Map) {
        userName <- map["user.name"]
        tweetText <- map["text"]
    }

    required init?(_ map: Map) { }
    
    init() { }
    
}
