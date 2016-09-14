//
//  AlertDialog.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/12.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class AlertDialog: NSObject {
    
    func showAlert(alertTitle: String, alertMessage: String, buttonTitle: [String], buttonAction: [()->Void]) {
        guard let view = UIApplication.sharedApplication().keyWindow!.rootViewController else {
            return
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        for i in 0..<buttonTitle.count {
            let button = UIAlertAction(title: buttonTitle[i], style: .Default) { (action) in
            buttonAction[i]()
            view.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(button)
        }
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlertSheet(alertTitle: String, alertMessage: String, selectionTitle: [String], selectionAction: [(Int)->()]) {
        guard let view = UIApplication.sharedApplication().keyWindow!.rootViewController else {
            return
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .ActionSheet)
        
        for i in 0..<selectionTitle.count {
            let select = UIAlertAction(title: selectionTitle[i], style: .Default) { (action) in
                selectionAction[i](i)
                view.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(select)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            view.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(cancel)
        
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func openSetting() {
        if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
}
