//
//  SSLotteryDetaTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class SSLotteryDetaTableViewCell: UITableViewCell {
	func setModel(model: SSLotteryJSModel) {
		lotterDataOpen.text = "第\(model.issueno)期 \(model.opendate)"
        var array = Array<String>()
        if !model.refernumber.isEmpty {
            array = model.number.components(separatedBy: " ") + model.refernumber.components(separatedBy: " ")
        } else {
            array = model.number.components(separatedBy: " ")
        }
        lotterSSNumberView.caipiaoId = model.caipiaoid
        lotterSSNumberView.numberArray = array
		lotterSSNumberView.numberBackColor = isfirst == true ? UIColor.orangeRedColor() : UIColor.white
		lotterSSNumberView.numberTextColor = isfirst == true ? UIColor.white : UIColor.orangeRedColor()
	}
	var isfirst: Bool = false
	@IBOutlet weak var lotterDataOpen: UILabel!
	@IBOutlet weak var lotterBackSSNumberView: UIView!
	var lotterSSNumberView = LotterySSNumberView()
	override func awakeFromNib() {
		super.awakeFromNib()
		lotterBackSSNumberView.addSubview(lotterSSNumberView)
		lotterSSNumberView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
	}
	override func layoutSubviews() {
		super.layoutSubviews()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
