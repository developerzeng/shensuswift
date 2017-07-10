//
//  SSLotteryRuleViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/16.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SSLotteryRuleViewController: BaseViewController {
    var talk:String!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.setNavTitle(title: "规则")
        textView.text = talk
        textView.layoutManager.allowsNonContiguousLayout = false;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func loadView() {
        Bundle.main.loadNibNamed("SSLotteryRuleViewController", owner: self, options: nil)
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
