//
//  PfNewsViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/5.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON
class PfNewsViewController: BaseViewController {
	var tableView: UITableView!
    var titleName:String!
	var newsData = Array<PfNewsModel>()
    var didSelectedRowBlock:((PfNewsModel)->())?
	override func viewDidLoad() {
		super.viewDidLoad()
       
		tableView = UITableView(frame: CGRect.zero, style: .grouped)
		tableView.delegate = self
		tableView.dataSource = self
        tableView.scrollsToTop = true
		tableView.showsVerticalScrollIndicator = false
		tableView.showsHorizontalScrollIndicator = false
		tableView.removfootViewLine()
		self.view.addSubview(tableView)
		tableView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		getNewsData()
		tableView.addRefreshingHeaderView {
			self.getNewsData()
		}
		// Do any additional setup after loading the view.
	}
	func getNewsData() {
        self.showLoadingView()
		let request = "http://www.fondfell.com/superDao/caipiao/index.php/Api/News/getNewList"
		NetWorkManager.default.rawRequestWithUrl(URLString: request, method: .post, parameters: ["path":titleName]) { (status, data) in
            self.hideLoadingView()
            self.tableView.endRefreshing()
			if status == .Success {
				self.newsData.removeAll()
				if let jsondata = data {
					let json = jsondata as? JSON
					if let snsMsgList = json?["result"].arrayObject {
						snsMsgList.enumerated().forEach({ (index, modeldata) in
							let model = PfNewsModel()
							_ = self.JsonMapToObject(JSON: modeldata, toObject: model)
							self.newsData.append(model)
						})
						self.tableView.safeReload()
					}
				}
			} else {
				self.showMessage(message: "数据加载失败")
			}
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
extension PfNewsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return newsData.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.01
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 5
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PfNewsTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("PfNewsTableViewCell", owner: self, options: nil)?.first as? PfNewsTableViewCell
		}
		if newsData.count > indexPath.section {
			cell?.setModel(model: newsData[indexPath.section])
		}
		cell?.selectionStyle = .none
		return cell!
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if newsData.count > indexPath.section {
			let model = newsData[indexPath.section]
//			let vc = PfNewsDetaViewController()
//			vc.agentId = model.oid
//			_ = self.navigationController?.pushViewController(vc, animated: true)
            self.didSelectedRowBlock?(model)
		}
	}
}
