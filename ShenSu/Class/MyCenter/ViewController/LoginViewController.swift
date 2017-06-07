//
//  LoginViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/2.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
class LoginViewController: BaseViewController {

	@IBOutlet weak var loginProblemBtn: UIButton!
	@IBAction func loginProblemP(_ sender: Any) {
		let alert = UIAlertController(title: "登录问题", message: nil, preferredStyle: .actionSheet)
		let actiondefault = UIAlertAction(title: "联系QQ客服", style: .default) { (action) in

		}
		let actionCancel = UIAlertAction(title: "取消", style: .cancel) { (action) in

		}
		alert.addAction(actiondefault)
		alert.addAction(actionCancel)
		self.present(alert, animated: true, completion: nil)
	}
	@IBAction func loginBtnClick(_ sender: Any) {
		self.view.endEditing(true)
		self.showLoadingView()
		let request = URLRouter.Login(accoutn: accountText.text!, password: passWordText.text!)
		NetWorkManager.default.requestURLRequestConvertible(URLString: request) { (status, data) in
			self.hideLoadingView()
			if status == .Success {
				if let jsondata = data {
					let json = JSON(jsondata)
					if json["status"].intValue == 2 {
						self.showMessage(message: json["info"].stringValue)
					} else {
						AppUserData.default.userAccount = self.accountText.text!
						AppUserData.default.password = self.passWordText.text!
						AppUserData.default.nickName = json["user_nicename"].stringValue
						AppUserData.default.isLogin = true
						self.showMessage(message: "登录成功")
						_ = self.dismissViewController()
					}
				}
			} else {
				self.showMessage(message: "网络请求失败")
			}
		}
	}
	@IBAction func openPwBtnClick(_ sender: Any) {
		passWordText.isSecureTextEntry = !passWordText.isSecureTextEntry
	}
	@IBOutlet weak var passWordText: UITextField!
	@IBOutlet weak var accountText: UITextField!

	@IBOutlet weak var openPwBtn: UIButton!
	@IBOutlet weak var loginBtn: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavTitle(title: "登录", color: UIColor.orangeRedColor())
		self.view.backgroundColor = UIColor.white
		self.setNavLeftButton(image: UIImage.init(named: "cha")!)
		self.setNavRightButtonTitle(title: "注册", color: UIColor.orangeRedColor())
		self.leftButtonClicked = { btn in
			self.dismissViewController()
		}
		self.rightButtonClicked = { btn in
			let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController")
			_ = self.navigationController?.pushViewController(vc, animated: true)
		}
		self.setNavBarWithColor(naviColor: UIColor.white, force: false)
		openPwBtn.adjustsImageWhenHighlighted = false
		loginProblemBtn.adjustsImageWhenHighlighted = false
		passWordText.clearsOnBeginEditing = true
		passWordText.clearButtonMode = .whileEditing
		accountText.keyboardType = .numberPad
		accountText.delegate = self
		passWordText.delegate = self
		loginBtn.alpha = 0.3
		loginBtn.isUserInteractionEnabled = false
		accountText.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
		passWordText.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
		// Do any additional setup after loading the view.
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		UIApplication.shared.statusBarStyle = .default
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.statusBarStyle = .lightContent
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
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
extension LoginViewController: UITextFieldDelegate {
	func textFieldChange(textfield: UITextField) {
		if textfield.text?.length ?? 0 > 11 {
			let text = textfield.text ?? ""
			let str = text.substring(to: text.index(text.startIndex, offsetBy: text.length - 1))
			textfield.text = str
		}
		if accountText.text?.length ?? 0 == 11 && passWordText.text?.length ?? 0 >= 6 {
			loginBtn.isUserInteractionEnabled = true
			loginBtn.alpha = 1
		} else {
			loginBtn.isUserInteractionEnabled = false
			loginBtn.alpha = 0.3
		}

	}
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if string == "\n" {
			self.view.endEditing(true)
			return false
		}
		return true
	}

}
