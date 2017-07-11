//
//  PfBuyLottreyCollectionViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/23.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy

class PfBuyLottreyCollectionViewCell: UICollectionViewCell {
	func setModel(model: PfBuyPfLotteryModel) {
		lotteryNumber.text = String(format: "%.2d", model.number.toInt()!)
		if model.isChoose {
			lotteryNumber.backgroundColor = UIColor.orangeRedColor()
			lotteryNumber.layer.borderColor = UIColor.clear.cgColor
			lotteryNumber.textColor = UIColor.white
		} else {
			lotteryNumber.backgroundColor = UIColor.white
			lotteryNumber.layer.borderColor = UIColor.orangeRedColor().cgColor
			lotteryNumber.textColor = UIColor.black
		}
	}
	var lotteryNumber: UILabel!
	override init(frame: CGRect) {
		super.init(frame: frame)
		lotteryNumber = UILabel()
		lotteryNumber.font = UIFont.systemFont(ofSize: 14)
		lotteryNumber.textAlignment = .center
		lotteryNumber.layer.borderWidth = 1
		lotteryNumber.textColor = UIColor.gray
		lotteryNumber.layer.borderColor = UIColor.black.cgColor
		self.contentView.addSubview(lotteryNumber)
		lotteryNumber <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		lotteryNumber.layer.cornerRadius = self.frame.width / 2
		lotteryNumber.layer.masksToBounds = true
	}
	override func layoutSubviews() {

	}
	override func prepareForReuse() {
		super.prepareForReuse()
		lotteryNumber.text = ""
		lotteryNumber.backgroundColor = UIColor.white
		lotteryNumber.layer.borderColor = UIColor.black.cgColor
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
