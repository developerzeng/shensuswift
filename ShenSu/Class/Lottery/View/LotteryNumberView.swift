//
//  LotteryNumberView.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class LotteryNumberView: UIView {
	var isspace: Bool = false
	var numberBackColor: UIColor = UIColor.orangeRedColor() {
		didSet {
			lableArray.enumerated().forEach { (index, data) in
				let lable = data as? UILabel
				lable?.backgroundColor = numberBackColor
			}
		}
	}
	var numberTextColor: UIColor = UIColor.white {
		didSet {
			lableArray.enumerated().forEach { (index, data) in
				let lable = data as? UILabel
				lable?.textColor = numberTextColor
			}
		}
	}
	var numberwidth: CGFloat = 30.0
	var numberArray: Array<String>! {
		didSet {
			var array = Array<String>()
			numberArray.enumerated().forEach { (index, str) in
				let classArray = str.components(separatedBy: "+")
				array += classArray
			}
			stringArray = array
			addNumberLable()
		}

	}
	var stringArray: Array<String>!
	func addNumberLable() {
		stringArray.enumerated().forEach { (index, model) in
			let numberLable = UILabel()
			numberLable.text = model
			numberLable.font = UIFont.systemFont(ofSize: 14)
			numberLable.backgroundColor = numberBackColor
			numberLable.textColor = numberTextColor
			numberLable.layer.cornerRadius = numberwidth / 2
			numberLable.textAlignment = .center
			numberLable.layer.masksToBounds = true
			self.addSubview(numberLable)
			lableArray.append(numberLable)
		}

	}
	override func layoutSubviews() {
		super.layoutSubviews()
		if numberArray != nil {
			let space = isspace != true ? (self.width - numberwidth * CGFloat(stringArray.count)) / CGFloat(stringArray.count + 1): 5
			let heightSpace = (self.height - numberwidth) / 2
			for i in 0..<lableArray.count {
				let lable = lableArray[i] as! UILabel
				if i == 0 {
					lable.frame = CGRect(x: space, y: heightSpace, w: numberwidth, h: numberwidth)
				} else {
					let leftLabel = lableArray[i - 1] as! UILabel
					lable.frame = CGRect(x: leftLabel.frame.x + numberwidth + space, y: heightSpace, w: numberwidth, h: numberwidth)
				}
			}
		}

	}
	var lableArray = Array<Any>()
	override init(frame: CGRect) {
		super.init(frame: frame)

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
