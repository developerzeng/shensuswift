//
//  BuyListViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/25.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
protocol BuyListreloadData {
	func reloadDataModels(models: Array<LotteryListModel>)
}
class BuyListViewController: BaseViewController {
	var footerView: BuyLotteryFooterView!
	var tableView: UITableView!
	var lotteryArray = Array<LotteryListModel>()
	var buyListdelegate: BuyListreloadData?
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavTitle(title: "订单")
		tableView = UITableView(frame: self.view.frame, style: .plain)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = UIColor.backColor()
		self.view.addSubview(tableView)
		let footer = BuyListFootView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 30))
		tableView.tableFooterView = footer
		addViewFoot()
		// Do any additional setup after loading the view.
	}
	func addViewFoot() {
		footerView = BuyLotteryFooterView()
		footerView.backgroundColor = UIColor.white
		footerView.goBtn.setTitle("确定选号", for: .normal)
		self.view.addSubview(footerView)
		footerView.clearBtnBlock = { [weak self] in
			self?.lotteryArray.removeAll()
			self?.tableView.reloadData()

		}
		footerView.goBtnBlock = { [weak self] in
			let alert = UIAlertController(title: nil, message: "抱歉，暂不支持互联网购彩，请前往附近彩票站购彩，是否保存选号记录?", preferredStyle: .alert)
			let defa = UIAlertAction(title: "保存", style: .default, handler: { (action) in
				if AppUserData.default.isLogin {
					if self?.lotteryArray.count != 0 {
						AppUserData.default.saveModel = self?.lotteryArray
						self?.showLoadingMessage(message: "保存中...")
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
							self?.showMessage(message: "保存成功")
						})
						DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
							self?.hideLoadingMessage()
							self?.lotteryArray.removeAll()
							let vc = ChoossFinishViewController()
							_ = self?.navigationController?.pushViewController(vc, animated: true)
						})
					} else {
						self?.showMessage(message: "您暂未选择")
					}
				} else {
					self?.showLoginViewController()
				}

			})
			let cancal = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in

			})
			alert.addAction(defa)
			alert.addAction(cancal)
			self?.present(alert, animated: true, completion: nil)

		}
		footerView <- [
			Bottom().to(self.view, .bottom),
			Left().to(self.view, .left),
			Right().to(self.view, .right),
			Height(50)
		]
		reloadCount()

	}
	func reloadCount() {
		var count = 0
		lotteryArray.enumerated().forEach { (index, model) in
			count += model.lotteryCount.toInt() ?? 0
		}
		footerView.setNumber(number: count.toString)
	}
	func setSaveModels() {

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidDisappear(_ animated: Bool) {
		self.buyListdelegate?.reloadDataModels(models: lotteryArray)
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
extension BuyListViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return lotteryArray.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BuyListTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("BuyListTableViewCell", owner: self, options: nil)?.first as? BuyListTableViewCell
		}
		cell?.selectionStyle = .none
		if lotteryArray.count > indexPath.row {
			cell?.setModel(model: lotteryArray[indexPath.row])
		}
		return cell!
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "删除"
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			lotteryArray.remove(at: indexPath.row)
		}
		tableView.deleteRows(at: [indexPath], with: .right)
		reloadCount()
	}

}
