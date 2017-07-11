//
//  PfUserRuleViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/2.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class PfUserRuleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title:"服务协议", color: UIColor.orangeRedColor())
        self.setNavBarWithColor(naviColor: UIColor.white, force: true)
        self.setNavLeftButton(image: UIImage.init(named: "or_back")!)
        self.leftButtonClicked = { btn in
            _ = self.navigationController?.popViewController(animated: true)
        }
        // Do any additional setup after loading the view.
    }
      convenience init() {
        
        var nibNameOrNil = String?("PfUserRuleViewController")
        
        //考虑到xib文件可能不存在或被删，故加入判断
        
        if Bundle.main.path(forResource: nibNameOrNil, ofType: "xib") == nil
            
        {
            
            nibNameOrNil = nil
            
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        
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
