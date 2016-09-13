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
    
    private let url = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
    private let alert = AlertDialog()
    private let disposeBag = DisposeBag()
    
    func request() -> Observable<[TwitterGetResponse]> {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                URL: url,
                                parameters: nil)
        
        request.account = TwitterClient.myAccount.value
        
        return getResponse(request)
    }
    
    private func getResponse(request: SLRequest) -> Observable<[TwitterGetResponse]> {
        var jsonArray = NSArray()
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
                
                response.onNext(Mapper<TwitterGetResponse>().mapArray(jsonArray)!)
            }
            return NopDisposable.instance
        }
    }
    
}
