//
//  NumberView.swift
//  ShenSu
//
//  Created by shensu on 17/5/17.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
public enum LotteryType: UInt {
    case DLT = 0
    case SSQ = 1
    case SSC = 3
}
class NumberView: UIView {
    // arc4random_uniform(max - min) + min
    
    var type: LotteryType = .DLT
    var number: Int {
        get {
            switch type {
            case LotteryType.DLT:
                return 7
            case LotteryType.SSQ:
                return 7
            default:
                return 5
            }
        }
    }
    /**
     刷新数据
     */
    func reloadView() {
        reloadData()
        for i in 0..<lableArray.count {
            let lable = lableArray[i]
            if numberArray.count > i {
                lable.text = numberArray[i]
            }
            trainanimation(lable: lable)
        }
        
    }
    func reloadData(){
    
        let random = randomModel.default
        switch type {
        case LotteryType.DLT:
            numberArray = random.setRandomfrom(fromNumber: 1, toNumber: 34, red: 5, bluefrom: 1, toBlue: 15, blue: 2)!
        case LotteryType.SSQ:
            numberArray = random.setRandomfrom(fromNumber: 1, toNumber: 34, red: 6, bluefrom: 1, toBlue: 15, blue: 1)!
        default:
            numberArray = random.setRandomfrom(fromNumber: 1, toNumber: 10, red: 5)!
        }

    }
    func trainanimation(lable: UILabel) {
        
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.x")
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = M_PI
        lable.layer.add(animation, forKey: "animationTransform")
        
    }
    var numberArray = Array<String>()
        
    var lableArray = Array<UILabel>()
    override init(frame: CGRect) {
        super.init(frame: frame)
        reloadData()
        for i in 0..<number {
            let lable = UILabel()
            lable.textColor = UIColor.white
            lable.layer.cornerRadius = 15
            if type == LotteryType.DLT {
                if i < 6 {
                    lable.backgroundColor = UIColor.orangeRedColor()
                } else {
                    lable.backgroundColor = UIColor.midnightBlueColor()
                }
            } else if type == LotteryType.SSQ {
                if i < 6 {
                    lable.backgroundColor = UIColor.orangeRedColor()
                } else {
                    lable.backgroundColor = UIColor.midnightBlueColor()
                }
            } else {
                lable.backgroundColor = UIColor.orangeRedColor()
            }
            

            lable.clipsToBounds = true
            // lable.layer.masksToBounds = true
            lable.font = UIFont.systemFont(ofSize: 12)
            lable.textAlignment = .center
            self.addSubview(lable)
            lableArray.append(lable)
            if numberArray.count > i {
                lable.text = numberArray[i]
            }
            
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let space = (self.width - 30.0 * CGFloat(numberArray.count + 1)) / CGFloat(numberArray.count)
        for i in 0..<lableArray.count {
            let lable = lableArray[i]
            if i == 0 {
                lable <- [
                    CenterY(0).to(self),
                    Left(space).to(self, .left),
                    Right(space).to(lableArray[i + 1], .left),
                    Size(CGSize(width: 30.0, height: 30.0))
                ]
            } else if i == lableArray.count - 1 {
                lable <- [
                    CenterY(0).to(self),
                    Left(space).to(lableArray[i - 1], .right),
                    // Right(5).to(self, .right).when { i == self.lableArray.count - 1 },
                    Size(CGSize(width: 30.0, height: 30.0))
                ]
            } else {
                lable <- [
                    CenterY(0).to(self),
                    Left(space).to(lableArray[i - 1], .right),
                    Right(space).to(lableArray[i + 1], .left).when { i != self.lableArray.count - 1 },
                    Size(CGSize(width: 30.0, height: 30.0))
                ]
                
            }
            
        }
        
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
