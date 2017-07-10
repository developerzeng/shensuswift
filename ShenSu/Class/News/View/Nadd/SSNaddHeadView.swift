//
//  SSNaddHeadView.swift
//  ShenSu
//
//  Created by shensu on 17/7/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy

class SSNaddHeadView: UIView {
    var zpbannar: LLCycleScrollView!
    var bannarArray :Array<SSBannarModel>! {
        didSet{
        var array = Array<String>()
        bannarArray.enumerated().forEach { (index,model) in
            array.append(model.bannarUrl)
        }
        zpbannar.imagePaths = array
        }
    }
    override init(frame: CGRect) {
      super.init(frame: frame)
      addBannar()
    
    }
    func addBannar() {
        zpbannar = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0, y: 0, w: self.width, h: 140))
        zpbannar.lldidSelectItemAtIndex = { index in
            if self.bannarArray.count > index {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "\(self.bannarArray[index].openUrl)")!, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        zpbannar.titleBackgroundColor = UIColor.clear
        zpbannar.imageViewContentMode = .scaleToFill
        zpbannar.customPageControlStyle = .pill
        zpbannar.customPageControlInActiveTintColor = UIColor.red
        // 下边约束
        zpbannar.pageControlBottom = 20
        self.addSubview(zpbannar)
        zpbannar <- [
            Top(0).to(self),
            Left(0).to(self),
            Right(0).to(self),
            Height(150)
        ]
        
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
