//
//  ViewController.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/09.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SendViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet private weak var textView: UITextView!
    
    @IBOutlet private weak var sendButton: UIBarButtonItem!
    
    @IBOutlet private weak var backButton: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    
    private let MAX_CHARACTERS = 140
    
    private let MIN_CHARACTERS = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    func setup() {
        
    }
    
    func bind() {
        textView.rx_text
            .filter{ [unowned self] in
                $0.characters.count >= self.MAX_CHARACTERS
            }
            .subscribeNext{ [unowned self] _ in
                self.textView.deleteBackward()
            }
            .addDisposableTo(disposeBag)
        
        textView.rx_text
            .map{ [unowned self] in
                $0.characters.count >= self.MIN_CHARACTERS
            }
            .subscribeNext{ [unowned self] in
                self.sendButton.enabled = $0
            }
            .addDisposableTo(disposeBag)
        
        backButton.rx_tap
            .subscribeNext{ [unowned self] in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            .addDisposableTo(disposeBag)
    }
}

