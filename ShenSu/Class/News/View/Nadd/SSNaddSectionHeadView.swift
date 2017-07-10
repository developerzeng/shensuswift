//
//  SSNaddSectionHeadView.swift
//  ShenSu
//
//  Created by shensu on 17/7/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SSNaddSectionHeadView: UIView {
   var segument : UISegmentedControl!
    var index:Int = 0 {
        didSet{
        segument.selectedSegmentIndex = index
        }
    }
   var segumentClickBlock:((Int)->())?
   override init(frame: CGRect) {
        super.init(frame: frame)
        segument = UISegmentedControl(items: ["中奖福地","足球资讯"])
        segument.frame = CGRect(x: 60, y: 5, w: self.width - 120, h: self.height - 10) 
        segument.tintColor = UIColor.orangeRedColor()
        segument.backgroundColor = UIColor.white
        segument.selectedSegmentIndex = index

        segument.addTarget(self, action: #selector(segumentClick), for: .valueChanged)
        self.addSubview(segument)
    
    }
    
    func segumentClick(sender:UISegmentedControl){
        
    self.segumentClickBlock?(sender.selectedSegmentIndex)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
