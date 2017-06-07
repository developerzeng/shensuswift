//
//  LotteryDetaTypeViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/31.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class LotteryDetaTypeViewController: BaseViewController {
	var tableView: UITableView!
	var headerView: LotteryDetaHeaderView!
	var lotteryName: String = ""
	var models = LotteryJSModel()
	var jsListModels = Array<JSListModel>()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavTitle(title: "期数详情")
		models.prize?.enumerated().forEach({ (index, model) in
			jsListModels.append(model)
		})
		if models.prize == nil {

			self.showMessage(message: "此种彩票暂无中奖信息!", delay: 1.0)
		}
		let jsListModel = JSListModel()
		jsListModel.prizename = "奖项"
		jsListModel.num = "中奖注数"
		jsListModel.singlebonus = "每注金额(元)"
		jsListModel.isFirst = true
		jsListModels.insert(jsListModel, at: 0)
		tableView = UITableView(frame: self.view.frame, style: .grouped)
		tableView.delegate = self
		tableView.dataSource = self
		headerView = LotteryDetaHeaderView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 165))
		headerView.setModel(model: models, lotteryTypeName: lotteryName)
		tableView.tableHeaderView = headerView
		self.view.addSubview(tableView)

		tableView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]

		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
extension LotteryDetaTypeViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return jsListModels.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LotteryDetaTypeTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("LotteryDetaTypeTableViewCell", owner: self, options: nil)?.first as? LotteryDetaTypeTableViewCell
		}
		if jsListModels.count > indexPath.row {
			cell?.setModel(model: jsListModels[indexPath.row])
		}
		cell?.selectionStyle = .none
		return cell!
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01
	}
}
