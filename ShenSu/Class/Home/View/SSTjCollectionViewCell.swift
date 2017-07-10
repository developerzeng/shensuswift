//
//  SSTjCollectionViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/5/17.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class SSTjCollectionViewCell: UICollectionViewCell {

    @IBAction func xuanhaoBtnClick(_ sender: Any) {
        self.xuanhaoBtnBlock?()
    }
    var xuanhaoBtnBlock:(()->())?
	@IBOutlet weak var buyBtn: UIButton!
	@IBOutlet weak var numberBackView: UIView!
	@IBOutlet weak var changBtn: UIButton!
	@IBOutlet weak var subType: UILabel!
	@IBOutlet weak var lotterType: UILabel!
	var homesaveBtnBlock: (() -> ())?
	var numberView: SSNumberView!
	var type: LotteryType {
		let ran = arc4random() % 3

		if ran == 0 {
			return .DLT
		} else if ran == 1 {
			return .SSQ
		} else {
			return .SSC
		}
	}

	@IBAction func buyBtnClick(_ sender: Any) {
		let model = SSLotteryListModel()
		model.lotteryType = lotterType.text ?? ""
		var str = ""
		numberView.numberArray.enumerated().forEach { (index, string) in
			if index == numberView.numberArray.count - 1 {
				str.append("\(string)")
			} else {
				str.append("\(string)|")
			}
		}
		model.lotteryNumber = str
		model.lotteryCount = "1"
		model.addtime = Date().toFormatDateString(format: "YYYY-MM-DD hh:mm")
		AppUserData.default.homesaveModel = [model]
		self.homesaveBtnBlock?()

	}
	@IBAction func changBtnClikc(_ sender: Any) {
		numberView.reloadView()
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		let rantype = type
        buyBtn.layer.cornerRadius = 4
		switch rantype {
		case .DLT:
			lotterType.text = "大乐透"
		case .SSQ:
			lotterType.text = "双色球"
		default:
			lotterType.text = "重庆时时彩"

		}
		self.contentView.backgroundColor = UIColor.white
		numberView = SSNumberView()
		numberView.type = rantype
		numberBackView.addSubview(numberView)
		numberView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		changBtn.layer.cornerRadius = 4
		subType.text = "奖池10亿奖金等你拿！"
	}
	override func layoutSubviews() {
		super.layoutSubviews()

	}

}
