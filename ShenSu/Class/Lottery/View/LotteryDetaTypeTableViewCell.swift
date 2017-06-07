//
//  LotteryDetaTypeTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/31.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class LotteryDetaTypeTableViewCell: UITableViewCell {

	@IBOutlet weak var eachPrice: UILabel!
	@IBOutlet weak var winPrice: UILabel!
	@IBOutlet weak var priceLable: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		eachPrice.layer.borderWidth = 0.5
		eachPrice.layer.borderColor = UIColor.lightGray.cgColor
		winPrice.layer.borderWidth = 0.5
		winPrice.layer.borderColor = UIColor.lightGray.cgColor
		priceLable.layer.borderWidth = 0.5
		priceLable.layer.borderColor = UIColor.lightGray.cgColor
		// Initialization code
	}
    
	func setModel(model: JSListModel) {
		priceLable.text = model.prizename
		winPrice.text = model.num
		eachPrice.text = model.singlebonus
		if model.isFirst {
			priceLable.textColor = UIColor.lightGray
			winPrice.textColor = UIColor.lightGray
			eachPrice.textColor = UIColor.lightGray
		} else {
			priceLable.textColor = UIColor.gray
			winPrice.textColor = UIColor.gray
			eachPrice.textColor = UIColor.orangeRedColor()
		}
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		priceLable.textColor = UIColor.lightGray
		winPrice.textColor = UIColor.lightGray
		eachPrice.textColor = UIColor.lightGray
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
