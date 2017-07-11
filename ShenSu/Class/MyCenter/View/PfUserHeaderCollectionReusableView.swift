//
//  PfUserHeaderCollectionReusableView.swift
//  ShenSu
//
//  Created by shensu on 17/6/1.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class PfUserHeaderCollectionReusableView: UICollectionReusableView {
	var tapGestureRecognizerBlock: (() -> ())?
	@IBOutlet weak var userNickNameLabel: UILabel!
	@IBOutlet weak var userIconImage: UIImageView!
	@IBOutlet weak var userBackImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
		userIconImage.isUserInteractionEnabled = true
		userIconImage.addGestureRecognizer(tap)

		// Initialization code
	}
	func reloadModel() {
		if AppUserData.default.isLogin {
			userIconImage.setImageWithURL(url: "http://www.1ywd.com/qmdb/statics/attachment/face/201610191007114836.png")
			userNickNameLabel.text = "可爱狼"
		} else {
			userIconImage.image = UIImage(named: "DefaultImage")
			userNickNameLabel.text = "未登录"
		}
	}
	func tapGestureRecognizer() {
		self.tapGestureRecognizerBlock?()
	}

}
