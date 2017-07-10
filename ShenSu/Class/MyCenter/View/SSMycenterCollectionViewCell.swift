//
//  SSMycenterCollectionViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/6/1.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SSMycenterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!

	@IBOutlet weak var titleLable: UILabel!
	@IBOutlet weak var titleImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
        colorView.backgroundColor = UIColor.clear
//		self.layer.cornerRadius = 4
		self.backgroundColor = UIColor.white
		// Initialization code
	}
	func setModel(model: MycenterModel) {
		titleImage.image = UIImage.init(named: model.iconImage)
		titleLable.text = model.title
	}

}
