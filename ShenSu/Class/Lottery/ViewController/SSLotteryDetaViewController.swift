//
//  SSLotteryDetaViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON

class SSLotteryDetaViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	var tableView: UITableView!
	var lotterModel: SSLotteryJSModel!
	var lotteryinfoArray = Array<SSLotteryJSModel>()
	var lotteryTypeArray = Array<SSHomeSSLotteryModel>()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavTitle(title: "\(lotterModel.lotteryName)历史开奖")
		tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.removfootViewLine()
		tableView.showsVerticalScrollIndicator = false
		tableView.showsVerticalScrollIndicator = false
		tableView.delegate = self
		tableView.dataSource = self
		self.view.addSubview(tableView)
		tableView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0))
		]
		self.tableView.addRefreshingHeaderView {
			self.setCPData()
		}
		getLotteryData()
		setCPData()
		addbuyLotteryBtn()
//		self.setNavRightButtonTitle(title: "走势图")
//		self.rightButtonClicked = { [weak self] btn in
//			for model in (self?.lotteryTypeArray)! {
//				if model.name == self?.lotterModel.name {
//					let vc = StylesViewController()
//					vc.ruleArray = model.rule
//					vc.titleName = model.name
//					vc.url = model.url
//					_ = self?.navigationController?.pushViewController(vc, animated: true)
//				}
//			}
//		}
		// Do any additional setup after loading the view.
	}
	func addbuyLotteryBtn() {
		let btn = UIButton(type: .custom)
		btn.setTitle("去选一注", for: .normal)
		btn.setTitleColor(UIColor.white, for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		btn.backgroundColor = UIColor.orangeRedColor()
		btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
		self.view.addSubview(btn)
		btn <- [
			Bottom(0).to(self.view, .bottom),
			Left(0).to(self.view, .left),
			Right(0).to(self.view, .right),
			Height(44)
		]
	}
	func btnClick() {
		for model in lotteryTypeArray {
			if model.name == lotterModel.lotteryName {
				let vc = SSBuyLottreyViewController()
				vc.lotteryData = model.rule
				vc.titleName = model.name
				vc.url = model.url
				_ = self.navigationController?.pushViewController(vc, animated: true)
			}
		}

	}
	func setCPData() {
		self.showLoadingView()
		let url = "http://api.jisuapi.com/caipiao/history?appkey=3afdff18fac4efeb&&caipiaoid=\(lotterModel.caipiaoid)&&num=20"

		NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .get, parameters: nil) { (status, data) in
			self.tableView.endRefreshing()
			self.hideLoadingView()
			if status == .Success {

				self.lotteryinfoArray.removeAll()
				if let jsondata = data {
					let json =   JSON(jsondata)
					if json["status"].stringValue == "0" {
						if let lotteryinfo = json["result"]["list"].arrayObject {
							lotteryinfo.enumerated().forEach({ (index, lott) in
								let model = SSLotteryJSModel()
								_ = self.JsonMapToObject(JSON: lott, toObject: model)
								self.lotteryinfoArray.append(model)
							})
							self.tableView.safeReload()
						}
					} else {
						self.showMessage(message: json["msg"].stringValue ?? "")
					}

				}
			} else {
				self.showMessage(message: "加载失败....")
			}
		}
	}
	func getLotteryData() {
		let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
		let dic = NSDictionary(contentsOfFile: path!)
		let array = dic?["data"] as? Array<Any>
		array?.enumerated().forEach({ (index, data) in
			let model = SSHomeSSLotteryModel()
			_ = self.JsonMapToObject(JSON: data, toObject: model)
			lotteryTypeArray.append(model)
		})

	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return lotteryinfoArray.count
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SSLotteryDetaTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("SSLotteryDetaTableViewCell", owner: self, options: nil)?.first as? SSLotteryDetaTableViewCell
		}
		cell?.selectionStyle = .none
		if lotteryinfoArray.count > indexPath.row {
			cell?.isfirst = indexPath.row == 0 ? true : false
			cell?.setModel(model: lotteryinfoArray[indexPath.row])
		}
		return cell!
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if lotteryinfoArray.count > indexPath.row {
			let vc = SSLotteryDetaTypeViewController()
			vc.models = lotteryinfoArray[indexPath.row]
			vc.lotteryName = lotterModel.lotteryName
			_ = self.navigationController?.pushViewController(vc, animated: true)
		}

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
