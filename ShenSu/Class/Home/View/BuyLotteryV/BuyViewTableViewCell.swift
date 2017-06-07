//
//  BuyViewTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/24.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class BuyViewTableViewCell: UITableViewCell {

	@IBOutlet weak var timeLable: UILabel!
	@IBOutlet weak var numberLable: UILabel!
	@IBOutlet weak var qishu: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()

	}
	func setModel(model: LotteryModel) {
		qishu.text = model.expect
		numberLable.text = model.opencode
		timeLable.text = model.opentimestamp.toFormatDateString(format: "MM/dd HH:mm")
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
