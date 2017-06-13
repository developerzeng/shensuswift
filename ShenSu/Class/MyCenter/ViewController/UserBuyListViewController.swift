//
//  UserBuyListViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/1.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
public enum LotterSaveType: UInt {
	case lotterSaveTypeBuy
	case lotterSaveTypeSave
}
class UserBuyListViewController: BaseViewController {
	var tableView: UITableView!
	var dataArray = Array<LotteryListModel>()
	var lotteryType: LotterSaveType = .lotterSaveTypeBuy
	override func viewDidLoad() {
		super.viewDidLoad()
        self.setNavRightButtonTitle(title: "分享")
        self.rightButtonClicked = { btn in
            let text = "彩票"
            let url = URL(string: "http://itunes.apple.com/us/app/id1218691138")
            let shareArray = [text, url!] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareArray, applicationActivities: nil)
            activityViewController.isModalInPopover = true
            self.present(activityViewController, animated: true, completion: nil)
            
        }
		if lotteryType == .lotterSaveTypeBuy {
			self.setNavTitle(title: "选号记录")
		} else {
			self.setNavTitle(title: "收藏历史")
		}

		tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.delegate = self
		tableView.dataSource = self
		self.view.addSubview(tableView)
		tableView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		tableView.removfootViewLine()
		setData()
		// Do any additional setup after loading the view.
	}
	func setData() {
		if lotteryType == .lotterSaveTypeBuy {
			if AppUserData.default.saveModel != nil {
				dataArray = AppUserData.default.saveModel!
			}
		} else {
			if AppUserData.default.saveModel != nil {
				dataArray = AppUserData.default.homesaveModel!
			}
		}

		tableView.safeReload()
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
extension UserBuyListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArray.count
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserBuyListTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("UserBuyListTableViewCell", owner: self, options: nil)?.first as? UserBuyListTableViewCell
		}
		cell?.selectionStyle = .none
		if dataArray.count > indexPath.row {
			cell?.setModel(model: dataArray[indexPath.row])
		}
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
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = CpMapViewController()
		_ = self.navigationController?.pushViewController(vc, animated: true)
	}
}
