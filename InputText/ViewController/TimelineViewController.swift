//
//  TimelineViewController.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TimelineViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    let data = TimelineViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setup()
        
        bind()
    }
    
    func setup() {
        tableview.dataSource = data
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 0
        
        data.setupTwitter()
    }
    
    func bind() {
        reloadButton.rx_tap
            .subscribeNext({ [unowned self] in
                self.data.get()
                self.tableview.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
}
