//
//  PfBuyListFootView.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class PfBuyListFootView: UIView {
	var ruleBtn: UIButton!
	var ruleLable: UILabel!
	override init(frame: CGRect) {
		super.init(frame: frame)
		ruleBtn = UIButton(type: .custom)
		ruleBtn.setImage(UIImage.init(named: "check39"), for: .normal)
		self.addSubview(ruleBtn)

		ruleLable = UILabel()
		ruleLable.text = "我已阅读并同意《用户服务协议》"
		ruleLable.font = UIFont.systemFont(ofSize: 12)
		self.addSubview(ruleLable)

		ruleBtn <- [
			CenterY().to(self),
			Size(20)
		]
		ruleLable <- [
			CenterX().to(self),
			CenterY().to(self),
			Left(5).to(ruleBtn, .right)
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
