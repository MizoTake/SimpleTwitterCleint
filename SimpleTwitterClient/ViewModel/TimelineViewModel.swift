//
//  TimelineViewModel.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class TimelineViewModel: NSObject, UITableViewDataSource {
    
    var checkGet = Variable<Bool>(false)
    
    private var entity: [TimelineEntity] = []
    
    private let getTimeline = TwitterGetRequest()
    
    private let twitterInfo = TwitterClient()
    
    private let disposeBag = DisposeBag()
    
    func setupTwitter() {
        twitterInfo.setup()
    }
    
    func get() {
        checkGet.value = false
        entity = []
        
        self.getTimeline.request()
            .subscribeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .subscribeNext { [unowned self] in
                $0.forEach {
                    self.entity.append(TimelineEntity())
                    self.entity[self.entity.endIndex - 1].register($0.tweetText, userName: $0.userName)
                }
                self.checkGet.value = true
            }
            .addDisposableTo(self.disposeBag)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entity.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as! TimelineCell
        
        cell.conect(entity[indexPath.row])
        return cell
    }

}
