//
//  PfHomeCollectionViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/17.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class PfHomeCollectionViewCell: UICollectionViewCell {
	func setModel(model: PfHomePfLotteryModel) {
        if model.ishot {

        }else{
 
        }
		lotteryImage.image = UIImage.init(named: model.name)
		lotteryLable.text = model.name
		lotterySubLable.text = model.subTitle
	}
    @IBOutlet weak var colorView: UIView!
	@IBOutlet weak var lotterySubLable: UILabel!
	@IBOutlet weak var lotteryLable: UILabel!
	@IBOutlet weak var lotteryImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
        self.backgroundColor = UIColor.white
        lotteryLable.textColor = UIColor.black
        lotterySubLable.textColor = UIColor.orangeRedColor()
        lotteryLable.textAlignment = .left
        lotterySubLable.textAlignment = .left
		self.layer.cornerRadius = 4
		// Initialization code
	}

}
