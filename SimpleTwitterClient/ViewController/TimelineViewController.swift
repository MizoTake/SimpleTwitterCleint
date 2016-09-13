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
    
    @IBOutlet private var tableview: UITableView!
    
    @IBOutlet private weak var reloadButton: UIBarButtonItem!
    
    @IBOutlet private weak var getButton: UIBarButtonItem!
    
    private let viewModel = TimelineViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setup()
        
        bind()
    }
    
    private func setup() {
        tableview.dataSource = viewModel
        
        viewModel.setupTwitter()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10000
    }
    
    private func bind() {
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
