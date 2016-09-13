//
//  TwitterGetRequest.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/12.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Accounts
import Social
import ObjectMapper

final class TwitterGetRequest: NSObject {
    
    let url = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
    let alert = AlertDialog()
    let disposeBag = DisposeBag()
    
    func request(account: ACAccount) -> Observable<[TwitterGetResponse]> {
        var jsonArray = NSArray()
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                URL: url,
                                parameters: nil)
        
        request.account = account
        
        return Observable.create { (response) in
            request.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
                if error != nil {
                    self.alert.showAlert("Error", alertMessage: "\(error)", buttonTitle: ["OK"], buttonAction: [{}])
                    return
                }
            
                do {
                    try jsonArray = NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments) as! NSArray
                } catch {
                    self.alert.showAlert("Error", alertMessage: "\(error)", buttonTitle: ["OK"], buttonAction:  [{}])
                    return
                }
            
                //print("result : "+"\(jsonArray)")
                response.onNext(Mapper<TwitterGetResponse>().mapArray(jsonArray)!)
            }
            return NopDisposable.instance
        }
        
        
    }
    
}
