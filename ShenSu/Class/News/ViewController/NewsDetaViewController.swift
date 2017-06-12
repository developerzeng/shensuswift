//
//  NewsDetaViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/5.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetaViewController: BaseViewController {
	var agentId: Int = 0
   
	@IBOutlet weak var titleLable: UILabel!
	@IBOutlet weak var subTitle: UITextView!
	@IBOutlet weak var timeTitle: UILabel!
	@IBOutlet weak var readLable: UILabel!
	@IBOutlet weak var buyBtn: UIButton!
    var lotteryTypeArray = Array<HomeLotteryModel>()
	var newDeatModel: NewsDataModel? {
		didSet {
            DispatchQueue.main.async {
                self.titleLable.text = self.newDeatModel?.expertReplayDetail.title
                let attr = try? NSMutableAttributedString.init(data: (self.newDeatModel?.expertReplayDetail.content.data(using: .unicode))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                self.subTitle.attributedText = attr
                self.timeTitle.text = "\(self.newDeatModel?.expertReplayDetail.author ?? "") \(self.newDeatModel?.expertReplayDetail.createTime ?? "")"
                self.readLable.text = "已有\(self.newDeatModel?.expertReplayDetail.clickCount ?? 0)看过"
            }

		}
	}
 
	override func loadView() {
		Bundle.main.loadNibNamed("NewsDetaViewController", owner: self, options: nil)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
        self.setNavTitle(title: "详情")
        getLotteryData()
        self.view.backgroundColor = UIColor.white
        buyBtn.backgroundColor = UIColor.orangeRedColor()
        subTitle.showsVerticalScrollIndicator = false
        subTitle.showsHorizontalScrollIndicator = false
		getNewsData()
		// Do any additional setup after loading the view.
	}
	func getNewsData() {
        self.showLoadingView()
		let request = "http://tt.aicai.com/api/expert/replay/detail/\(agentId)?agentId=\(agentId)&appVersion=4.1.0&platform=wap&version="
		NetWorkManager.default.rawRequestWithUrl(URLString: request, method: .get, parameters: nil) { (status, data) in
            self.hideLoadingView()
			if status == .Success {
				if let jsondata = data {
					let json = jsondata as? JSON
					if let snsMsgList = json?.object {

						let model = NewsDataModel()
						_ = self.JsonMapToObject(JSON: snsMsgList, toObject: model)
						self.newDeatModel = model
					}
				}
			} else {
				self.showMessage(message: "数据加载失败")
			}
		}
	}

	@IBAction func buyBtnClick(_ sender: Any) {
        let rand =  arc4random() % UInt32(lotteryTypeArray.count - 1)
        let  model = lotteryTypeArray[Int(rand)]
        
                let vc = BuyLottreyViewController()
                vc.lotteryData = model.rule
                vc.titleName = model.name
                vc.url = model.url
                _ = self.navigationController?.pushViewController(vc, animated: true)
        
        
	}
    func getLotteryData() {
        let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
        let dic = NSDictionary(contentsOfFile: path!)
        let array = dic?["data"] as? Array<Any>
        array?.enumerated().forEach({ (index, data) in
            let model = HomeLotteryModel()
            _ = self.JsonMapToObject(JSON: data, toObject: model)
            lotteryTypeArray.append(model)
        })
        
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
