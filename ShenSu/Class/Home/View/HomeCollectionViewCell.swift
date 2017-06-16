//
//  HomeCollectionViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/17.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
	func setModel(model: HomeLotteryModel) {
        
		lotteryImage.image = UIImage.init(named: model.name)
		lotteryLable.text = model.name
		lotterySubLable.text = model.subTitle
	}
	@IBOutlet weak var lotterySubLable: UILabel!
	@IBOutlet weak var lotteryLable: UILabel!
	@IBOutlet weak var lotteryImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
        lotteryLable.textColor = UIColor.white
        lotterySubLable.textColor = UIColor.white
		self.layer.cornerRadius = 4
		// Initialization code
	}

}
