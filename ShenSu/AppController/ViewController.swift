//
//  ViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/9.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
	var manager: NetworkReachabilityManager?
	var window: UIWindow? = UIApplication.shared.keyWindow
	@IBAction func chackNetWorkClick(_ sender: Any) {
		observeNetWork()
	}
	@IBOutlet weak var chackNetWork: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
	//	chackNetWork.layer.cornerRadius = 4

		// Do any additional setup after loading the view, typically from a nib.
	}
	func observeNetWork() {
		self.manager = NetworkReachabilityManager(host: "www.baidu.com")
		self.manager?.listener = { status in
			if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable {
				self.showMessage(message: "还是无法连接网络哦！")
			} else if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown {
			} else {
				self.addActionInfo()
			}
			self.manager?.stopListening()
		}
		self.manager?.startListening()
	}
	func addActionInfo() {

		NetWorkManager.default.requestAppinfo { (status, data) in
			if status == .Success {
				if let datajson = data {
					let json = datajson as? JSON
					if let dic = json?.dictionaryObject {
						if dic["url"] as? String != "" {
							let vc = WKWebViewController()
							vc.url = dic["url"] as? String ?? ""
							vc.isAddFoot = dic["foot"] as? Bool ?? false
							self.window?.rootViewController = vc
							self.window?.makeKeyAndVisible()
						}

					}
				}
			} else {

			}
		}

	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

