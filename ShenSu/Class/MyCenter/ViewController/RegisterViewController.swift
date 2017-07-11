//
//  PfRegisterViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/2.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
class RegisterViewController: BaseViewController {

    @IBAction func userRuleClick(_ sender: Any) {
        let vc = PfUserRuleViewController()
        _ = self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var userRule: UIButton!
    @IBAction func goforwatBtnClick(_ sender: Any) {
     self.showLoadingView()
     let request = URLRouter.regist(account: userAccount.text!, password: passWord.text!)
      NetWorkManager.default.requestURLRequestConvertible(URLString: request) { (status, data) in
        self.hideLoadingView()
        if status == .Success {
            if let jsondata = data {
             let json = JSON(jsondata)
                if json["status"].intValue == 2 {
                self.showMessage(message: json["info"].stringValue)
                }else{
                AppUserData.default.userAccount = self.userAccount.text!
                AppUserData.default.password = self.passWord.text!
                AppUserData.default.isLogin = true
                self.showMessage(message: "注册成功")
                _ = self.dismissViewController()
                }
            }
        }else {
        self.showMessage(message: "网络请求失败")
        }
      }
        
    }
    @IBOutlet weak var goforwat: UIButton!
    @IBAction func openBtnClick(_ sender: Any) {
        passWord.isSecureTextEntry = !passWord.isSecureTextEntry
    }
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userAccount: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setNavTitle(title: "注册", color: UIColor.orangeRedColor())
		self.setNavBarWithColor(naviColor: UIColor.white, force: true)
		self.setNavLeftButton(image: UIImage.init(named: "or_back")!)
		self.leftButtonClicked = { btn in
			_ = self.navigationController?.popViewController(animated: true)
		}
        passWord.clearsOnBeginEditing = true
        passWord.clearButtonMode = .whileEditing
        userAccount.keyboardType = .numberPad
        userAccount.delegate = self
        passWord.delegate = self
        goforwat.alpha = 0.3
        goforwat.isUserInteractionEnabled = false
        userAccount.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        passWord.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)

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
extension RegisterViewController: UITextFieldDelegate {
    func textFieldChange(textfield: UITextField) {
        if textfield.text?.length ?? 0 > 11 {
            let text = textfield.text ?? ""
            let str = text.substring(to: text.index(text.startIndex, offsetBy: text.length - 1))
            textfield.text = str
        }
        if userAccount.text?.length ?? 0 == 11 && passWord.text?.length ?? 0 >= 6 {
            goforwat.isUserInteractionEnabled = true
            goforwat.alpha = 1
        } else {
            goforwat.isUserInteractionEnabled = false
            goforwat.alpha = 0.3
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
