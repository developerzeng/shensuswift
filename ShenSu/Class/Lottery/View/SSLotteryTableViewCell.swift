//
//  SSLotteryTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class SSLotteryTableViewCell: UITableViewCell {
	func setModel(model: SSLotteryJSModel) {
		lotteryLable.text = model.lotteryName
		lotteryOpen.text = "第\(model.issueno)期 \(model.opendate)"
		var array = Array<String>()
		if !model.refernumber.isEmpty {
			array = model.number.components(separatedBy: " ") + model.refernumber.components(separatedBy: " ")
		} else {
			array = model.number.components(separatedBy: " ")
		}
        lotterSSNumberView.caipiaoId = model.caipiaoid
		lotterSSNumberView.numberArray = array

	}
	@IBOutlet weak var lotteryView: UIView!
    @IBOutlet weak var backView: UIView!
	@IBOutlet weak var lotteryOpen: UILabel!
	@IBOutlet weak var lotteryLable: UILabel!
	var lotterSSNumberView = LotterySSNumberView()
	override func awakeFromNib() {
		super.awakeFromNib()
        backView.backgroundColor = UIColor.seaGreenColor()
        
//        self.contentView.layer.cornerRadius = 8
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
		lotterSSNumberView.isspace = true
		lotteryView.addSubview(lotterSSNumberView)
		lotterSSNumberView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}
       
    
    
}
