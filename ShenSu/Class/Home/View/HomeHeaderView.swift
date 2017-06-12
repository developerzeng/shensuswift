//
//  HomeHeaderView.swift
//  ShenSu
//
//  Created by shensu on 17/5/16.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
import EasyPeasy
class HomeHeaderView: UICollectionReusableView {
	var zpbannar: LLCycleScrollView!
	var bannarArray = Array<BannarModel>()
	var chooseView: ChooseView!
	var openBananrUrl: ((String) -> ())?
	override init(frame: CGRect) {
		super.init(frame: frame)
		addBannar()
		addScrollerView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	/*
	 // Only override draw() if you perform custom drawing.
	 // An empty implementation adversely affects performance during animation.
	 override func draw(_ rect: CGRect) {
	 // Drawing code
	 }
	 */
	func addScrollerView() {
		chooseView = ChooseView()
		self.addSubview(chooseView)
		chooseView <- [
			Top(-5).to(zpbannar, .bottom),
			Left(0).to(self),
			Right(0).to(self),
			Height(30)
			// Bottom(10).to(self)
		]
	}

	func addBannar() {
		zpbannar = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0, y: 0, w: self.width, h: 140))
		zpbannar.lldidSelectItemAtIndex = { index in
			if self.bannarArray.count > index {
				self.openBananrUrl?("\(self.bannarArray[index].openUrl)")

			}
		}
		zpbannar.titleBackgroundColor = UIColor.clear
		zpbannar.imageViewContentMode = .scaleToFill
		zpbannar.customPageControlStyle = .pill
		zpbannar.customPageControlInActiveTintColor = UIColor.red
		// 下边约束
		zpbannar.pageControlBottom = 20
		self.addSubview(zpbannar)
		zpbannar <- [
			Top(0).to(self),
			Left(0).to(self),
			Right(0).to(self),
			Height(150)
		]

	}

}
