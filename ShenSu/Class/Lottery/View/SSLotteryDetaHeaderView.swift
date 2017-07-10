//
//  SSLotteryDetaHeaderView.swift
//  ShenSu
//
//  Created by shensu on 17/5/31.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class SSLotteryDetaHeaderView: BaseView {

	@IBOutlet weak var saveNumberLable: UILabel!
	@IBOutlet weak var saleNumberLable: UILabel!
	@IBOutlet weak var openCodeView: UIView!
	@IBOutlet weak var titleLable: UILabel!
	@IBOutlet weak var lotteryName: UILabel!
	var lotterSSNumberView = LotterySSNumberView()
	override init(frame: CGRect) {
		super.init(frame: frame)
		saveNumberLable.textColor = UIColor.orangeRedColor()
		saleNumberLable.textColor = UIColor.orangeRedColor()
		openCodeView.addSubview(lotterSSNumberView)
		lotterSSNumberView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
	}
	func setModel(model: SSLotteryJSModel, lotteryTypeName: String) {
		lotteryName.text = lotteryTypeName
		titleLable.text = "第\(model.issueno)期 \(model.opendate)"
		saleNumberLable.text = model.saleamount
		saveNumberLable.text = model.totalmoney
		var array = Array<String>()
		if !model.refernumber.isEmpty {
			array = model.number.components(separatedBy: " ") + model.refernumber.components(separatedBy: " ")
		} else {
			array = model.number.components(separatedBy: " ")
		}
		lotterSSNumberView.numberArray = array
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
