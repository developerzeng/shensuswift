//
//  BuyViewFooterView.swift
//  ShenSu
//
//  Created by shensu on 17/5/24.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class BuyViewHeaderView: UIView {
	var rowCount: Int {
		return Int(self.height) / 30 - 1
	}
	var lotteryinfoArray = Array<LotteryModel>() {
		didSet {
			tableview.reloadData()
		}
	}
	var tableview: UITableView!
	override init(frame: CGRect) {
		super.init(frame: frame)
		addtabView()
	}
	func addtabView() {
		tableview = UITableView(frame: CGRect.zero, style: .plain)
		tableview.delegate = self
		tableview.dataSource = self
		tableview.showsVerticalScrollIndicator = false
		tableview.showsHorizontalScrollIndicator = false
		self.addSubview(tableview)
		tableview <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		tableview.isEditing = false
		tableview.isScrollEnabled = false
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

}
extension BuyViewHeaderView: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return lotteryinfoArray.count > 0 ? rowCount : 0
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableview.dequeueReusableCell(withIdentifier: "cell") as? BuyViewTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("BuyViewTableViewCell", owner: self, options: nil)?.first as! BuyViewTableViewCell?
		}
		if lotteryinfoArray.count > indexPath.row {
			cell?.setModel(model: lotteryinfoArray[indexPath.row])
		}
        cell?.backgroundColor = UIColor.white
		cell?.selectionStyle = .none
		return cell!
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 40
	}
}
