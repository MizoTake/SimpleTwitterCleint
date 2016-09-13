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
    
    @IBOutlet weak var getButton: UIBarButtonItem!
    
    let viewModel = TimelineViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setup()
        
        bind()
    }
    
    func setup() {
        tableview.dataSource = viewModel
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10000
        
        viewModel.setupTwitter()
    }
    
    func bind() {
        getButton.rx_tap
            .subscribeNext { [unowned self] in
                self.viewModel.get()
            }
            .addDisposableTo(disposeBag)
        
        reloadButton.rx_tap
            .subscribeNext { [unowned self] in
                self.tableview.reloadData()
            }
            .addDisposableTo(disposeBag)
        
        viewModel.checkGet.asObservable()
            .subscribeNext { [unowned self] in
                self.reloadButton.enabled = $0
            }
            .addDisposableTo(disposeBag)
    }
    
}
