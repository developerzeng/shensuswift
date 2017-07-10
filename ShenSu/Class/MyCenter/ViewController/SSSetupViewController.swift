//
//  SSSetupViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
struct SetupModel {
	var imageName: String!
	var title: String!
	var isswitch: Bool = false
}
class SSSetupViewController: BaseViewController {
	var tableView: UITableView!
	var dataArray: Array<SetupModel>! {
		let model = SetupModel(imageName: "yyy", title: "摇一摇机选", isswitch: AppUserData.default.yyypush)
		let model1 = SetupModel(imageName: "zj", title: "中奖提醒", isswitch: AppUserData.default.zjpush)
		let model2 = SetupModel(imageName: "kj", title: "开奖提醒", isswitch: AppUserData.default.kjpush)
		let mdoel3 = SetupModel(imageName: "gc", title: "购彩提醒", isswitch: AppUserData.default.gcpush)
		return [model, model1, model2, mdoel3]
	}
	func setlonginout() {
		let view = UIView(frame: CGRect(x: 0, y: 0, w: self.tableView.width, h: 44))
	
		let btn = UIButton(type: .custom)
		if AppUserData.default.isLogin {
			btn.setTitle("注销", for: .normal)
		} else {
			btn.setTitle("登录", for: .normal)
		}
		btn.backgroundColor = UIColor.orangeRedColor()
		btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
		btn.layer.cornerRadius = 4
		btn.frame = CGRect(x: 15, y: 0, w: self.view.width - 30, h: 44)
		view.addSubview(btn)
		self.tableView.tableFooterView = view

	}
	func btnClick() {
		if AppUserData.default.isLogin {
			AppUserData.default.isLogin = false
		}
		self.showLoginViewController()

	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavTitle(title: "设置")
		tableView = UITableView(frame: CGRect.zero, style: .grouped)
		tableView.showsVerticalScrollIndicator = false
		tableView.showsHorizontalScrollIndicator = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.removfootViewLine()
		self.view.addSubview(tableView)
		tableView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
        setlonginout()
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
extension SSSetupViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return dataArray.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SSSetupTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("SSSetupTableViewCell", owner: self, options: nil)?.first as? SSSetupTableViewCell
		}
		cell?.setupSwitchBlock = { spswitch in
			self.showMessage(message: "保存中....", delay: 0.5)

			spswitch.setOn(!spswitch.isOn, animated: true)
			switch indexPath.section {
			case 0:
				AppUserData.default.yyypush = spswitch.isOn
			case 1:
				AppUserData.default.zjpush = spswitch.isOn
			case 2:
				AppUserData.default.kjpush = spswitch.isOn
			case 3:
				AppUserData.default.gcpush = spswitch.isOn
			default:
				break
			}
		}
		if dataArray.count > indexPath.section {
			cell?.setModel(model: dataArray[indexPath.section])
		}
		return cell!
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 5
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.01
	}

}
