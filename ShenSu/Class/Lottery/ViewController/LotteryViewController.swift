//
//  LotteryViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON
class LotteryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	var tableView: UITableView!
	var lotteryArray = Array<HomeLotteryModel>()
	var lotteryinfoArray = Array<LotteryJSModel>()
	override func viewDidLoad() {
		super.viewDidLoad()

		tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.removfootViewLine()
		tableView.showsVerticalScrollIndicator = false
		tableView.showsVerticalScrollIndicator = false
		tableView.delegate = self
		tableView.dataSource = self
		self.view.addSubview(tableView)
		tableView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		getLotteryData()
		getopenCode()
		// group()
		self.setNavRightButton(image: UIImage.init(named: "guangao")!)
		self.rightButtonClicked = { [weak self] btn in

			let vc = LotterypushTableViewController()
			_ = self?.navigationController?.pushViewController(vc, animated: true)

		}
		tableView.addRefreshingHeaderView {
            self.lotteryinfoArray.removeAll()
            self.tableView.safeReload()
			self.getopenCode()
		}
        self.setNavRightButton(image: UIImage.init(named: "seachbar")!)
        self.rightButtonClicked = { btn in
            let vc = SeachViewController()
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
		// Do any additional setup after loading the view.
	}

	func requestopenCode(model: HomeLotteryModel, group: DispatchGroup) {

		let url = "http://api.jisuapi.com/caipiao/history?appkey=3afdff18fac4efeb&&caipiaoid=\(model.caipiaoid!)&&num=1"

		NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .get, parameters: nil) { (status, data) in
			if status == .Success {
				if let jsondata = data {
					let json = jsondata as? JSON
					if json?["status"].stringValue == "0" {
						if let lotteryinfo = json?["result"]["list"].arrayObject {
							lotteryinfo.enumerated().forEach({ (index, lott) in
								let model = LotteryJSModel()
								_ = self.JsonMapToObject(JSON: lott, toObject: model)
								model.caipiaoid = (json?["result"]["caipiaoid"].stringValue)!
								self.lotteryinfoArray.append(model)

							})
						}
					}
				}
			}
			group.leave()
		}

	}

	func getopenCode() {
		self.showLoadingView()
		let group = DispatchGroup()
		let myQueue = DispatchQueue.global()

		lotteryArray.enumerated().forEach({ (index, model) in
			group.enter()
			myQueue.async(group: group, qos: .default, flags: [], execute: {

				self.requestopenCode(model: model, group: group)
			})
		})
		group.notify(queue: .main) {
			self.tableView.safeReload()
            self.tableView.endRefreshing()
			self.hideLoadingView()
		

		}

	}
	func getLotteryData() {
		let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
		let dic = NSDictionary(contentsOfFile: path!)
		let array = dic?["data"] as? Array<Any>
		array?.enumerated().forEach({ (index, data) in
			let model = HomeLotteryModel()
			_ = self.JsonMapToObject(JSON: data, toObject: model)
			lotteryArray.append(model)
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
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LotteryTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("LotteryTableViewCell", owner: self, options: nil)?.first as? LotteryTableViewCell
		}
		cell?.selectionStyle = .none
		if lotteryinfoArray.count > indexPath.row {
			cell?.setModel(model: lotteryinfoArray[indexPath.row])
		}

		return cell!
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if lotteryinfoArray.count > indexPath.row {
			let model = lotteryinfoArray[indexPath.row]
			let vc = LotteryDetaViewController()
			vc.lotterModel = model
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
