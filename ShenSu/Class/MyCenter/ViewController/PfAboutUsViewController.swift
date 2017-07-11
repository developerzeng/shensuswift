//
//  PfAboutUsViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/5.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class PfAboutUsViewController: BaseViewController {
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var versionLable: UILabel!
    override func loadView() {
        Bundle.main.loadNibNamed("PfAboutUsViewController", owner: self, options: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let infodic = Bundle.main.infoDictionary
        appName.text = infodic?["CFBundleName"] as? String
        versionLable.text = "版本： \(infodic?["CFBundleShortVersionString"] ?? "")"
      
 
        appIcon.image = UIImage(named:"appicon")
        
       
        
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
