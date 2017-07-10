//
//  UserSSBuyListTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/6/1.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class UserSSBuyListTableViewCell: UITableViewCell {

	@IBOutlet weak var lotteryName: UILabel!
	@IBOutlet weak var qishuLable: UILabel!
	@IBOutlet weak var lotteryCount: UILabel!
	@IBOutlet weak var lotteryNumber: UILabel!
	@IBOutlet weak var lotteryImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func setModel(model: SSLotteryListModel) {
		lotteryName.text = model.lotteryType
		lotteryImage.image = UIImage(named: model.lotteryType)
		lotteryNumber.text = model.lotteryNumber
		setNumber(number: model.lotteryCount)
		if model.lotteryExpect != "" {
			qishuLable.text = "第\(model.lotteryExpect)期"
		} else {
			qishuLable.text = "收藏时间:\(model.addtime)"
		}

	}
	func setNumber(number: String) {

		let attr = NSMutableAttributedString(string: "共")
		let attr1 = NSMutableAttributedString(string: "注")
		let attr2 = NSMutableAttributedString(string: number)
		attr2.addAttributes([NSForegroundColorAttributeName: UIColor.orangeRedColor()], range: NSMakeRange(0, attr2.length))
		attr.append(attr2)
		attr.append(attr1)
		lotteryCount.attributedText = attr
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
