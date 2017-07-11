//
//  PfBuyLotteryFooterView.swift
//  ShenSu
//
//  Created by shensu on 17/5/24.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class PfBuyLotteryFooterView: UIView {
	var clearBtn: UIButton!
	var numberLabel: UILabel!
	var goBtn: UIButton!
	var clearBtnBlock: (() -> ())?
	var goBtnBlock: (() -> ())?
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor(rgb: 0xf2f2f2)
		clearBtn = UIButton(type: .custom)
		clearBtn.setImage(UIImage.init(named: "delete"), for: .normal)
		clearBtn.adjustsImageWhenHighlighted = false
		clearBtn.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
		self.addSubview(clearBtn)

		numberLabel = UILabel()
		numberLabel.font = UIFont.systemFont(ofSize: 14)
		numberLabel.textAlignment = .center
		setNumber(number: "0")
		self.addSubview(numberLabel)

		goBtn = UIButton(type: .custom)
		goBtn.layer.borderColor = UIColor.orangeRedColor().cgColor
		goBtn.layer.borderWidth = 1
		goBtn.backgroundColor = UIColor.white
		goBtn.setTitle("下一步", for: .normal)
		goBtn.layer.cornerRadius = 4
		goBtn.setTitleColor(UIColor.orangeRedColor(), for: .normal)
		goBtn.adjustsImageWhenHighlighted = false
		goBtn.addTarget(self, action: #selector(goBtnClick), for: .touchUpInside)
		self.addSubview(goBtn)
		clearBtn <- [
			Top(0).to(self, .top),
			Left(5).to(self, .left),
			Bottom(0).to(self, .bottom),
			Width(30)
		]
		numberLabel <- [
			Top(0).to(self, .top),
			CenterX(0).to(self, .centerX),
			Bottom(0).to(self, .bottom),
			Width(130)
		]
		goBtn <- [
			Top(5).to(self, .top),
			Right(5).to(self, .right),
			Bottom(5).to(self, .bottom),
			Width(80)
		]
	}
	func clearBtnClick() {
		self.clearBtnBlock?()
	}
	func goBtnClick() {
		self.goBtnBlock?()
	}
	func setNumber(number: String) {
		let attr = NSMutableAttributedString(string: "共")
		let attr1 = NSMutableAttributedString(string: "注")
		let attr2 = NSMutableAttributedString(string: number)
		attr2.addAttributes([NSForegroundColorAttributeName: UIColor.orangeRedColor()], range: NSMakeRange(0, attr2.length))
		attr.append(attr2)
		attr.append(attr1)
		numberLabel.attributedText = attr
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
