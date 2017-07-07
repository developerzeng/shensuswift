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
        if model.ishot {
     
        }else{
       
        }
		lotteryImage.image = UIImage.init(named: model.name)
		lotteryLable.text = model.name
		lotterySubLable.text = model.subTitle
	}
    func setNewModel(model: NewLotteryModel) {
        lotteryImage.image = UIImage(named:model.lot_pic)
        lotteryLable.text = model.lot_name
        lotterySubLable.text = model.lot_title
        
    }
    @IBOutlet weak var colorView: UIView!
	@IBOutlet weak var lotterySubLable: UILabel!
	@IBOutlet weak var lotteryLable: UILabel!
	@IBOutlet weak var lotteryImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
         colorView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.white
        lotteryLable.textColor = UIColor.black
        lotterySubLable.textColor = UIColor.lightGray
	//	self.layer.cornerRadius = 4
		// Initialization code
	}

}
