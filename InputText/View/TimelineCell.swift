//
//  TimelineCell.swift
//  InputText
//
//  Created by 溝口 健 on 2016/09/13.
//  Copyright © 2016年 溝口 健. All rights reserved.
//

import UIKit

final class TimelineCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    func conect(entity: TimelineEntity) {
        textView.text = entity.tweetText
        print("適応 " + entity.tweetText)
    }
}
