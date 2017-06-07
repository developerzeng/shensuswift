//
//  BuyLotteryHeardCollectionReusableView.swift
//  ShenSu
//
//  Created by shensu on 17/5/24.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class BuyLotteryHeardCollectionReusableView: UICollectionReusableView {
	private var headerLable: UILabel!
	override init(frame: CGRect) {

		super.init(frame: frame)
		headerLable = UILabel()
		headerLable.frame = CGRect(x: 15, y: 0, w: frame.width - 15, h: frame.height)
		headerLable.font = UIFont.systemFont(ofSize: 14)
		headerLable.textColor = UIColor.lightGray
		self.addSubview(headerLable)

	}
	func setLableText(text: String) {
		headerLable.text = text as String
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
