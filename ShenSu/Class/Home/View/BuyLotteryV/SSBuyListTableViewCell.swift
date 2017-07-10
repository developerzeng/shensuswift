//
//  SSBuyListTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/25.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SSBuyListTableViewCell: UITableViewCell {

	@IBOutlet weak var lotteryCount: UILabel!
	@IBOutlet weak var lotteryNumber: UILabel!
	@IBOutlet weak var lotteryImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func setModel(model: SSLotteryListModel) {
		let attr = NSMutableAttributedString(string: "共")
		let attr1 = NSMutableAttributedString(string: "注")
		let attr2 = NSMutableAttributedString(string: model.lotteryCount)
		attr2.addAttributes([NSForegroundColorAttributeName: UIColor.orangeRedColor()], range: NSMakeRange(0, attr2.length))
		attr.append(attr2)
		attr.append(attr1)

		lotteryCount.attributedText = attr
		lotteryNumber.text = model.lotteryNumber
		lotteryImage.image = UIImage(named: model.lotteryType)
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
