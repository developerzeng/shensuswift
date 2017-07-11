//
//  SSLotteryViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON
enum CpType:UInt {
    case allCp
    case gpCp
    case dpCp
}
class SSLotteryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
	var tableView: UITableView!
	var lotteryArray = Array<SSHomeSSLotteryModel>()
	var lotteryinfoArray = Array<SSLotteryJSModel>()
    var cpType:CpType = .allCp
    var gaopingArray:Array<SSLotteryJSModel> {
       let array = ["73","82","93","90","75","69","83","115","94"]
       var gpA = Array<SSLotteryJSModel>()
       lotteryinfoArray.enumerated().forEach { (index,model) in
        array.enumerated().forEach({ (_,cpid) in
            if model.caipiaoid == cpid {
            gpA.append(model)
            }
        })
        }
        return gpA
    }
    var dipingArray:Array<SSLotteryJSModel>{
        let array = ["11","14","12"]
        var gpA = Array<SSLotteryJSModel>()
        lotteryinfoArray.enumerated().forEach { (index,model) in
            array.enumerated().forEach({ (_,cpid) in
                if model.caipiaoid == cpid {
                    gpA.append(model)
                }
            })
        }
        return gpA
    
    }
    var   segment : UISegmentedControl!
	override func viewDidLoad() {
		super.viewDidLoad()
        addScrollView()
		tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.removfootViewLine()
		tableView.showsVerticalScrollIndicator = false
		tableView.showsVerticalScrollIndicator = false
		tableView.delegate = self
		tableView.dataSource = self
        tableView.backgroundColor = self.view.backgroundColor
		self.view.addSubview(tableView)
		tableView <- [
			Edges(UIEdgeInsets(top: 40, left: 5, bottom: 0, right: 5))
		]
		getLotteryData()
		getopenCode()
		// group()
		self.setNavRightButton(image: UIImage.init(named: "guangao")!)
		self.rightButtonClicked = { [weak self] btn in

			let vc = SSLotterypushTableViewController()
			_ = self?.navigationController?.pushViewController(vc, animated: true)

		}
		tableView.addRefreshingHeaderView {
            self.lotteryinfoArray.removeAll()
            self.tableView.safeReload()
			self.getopenCode()
		}
//        self.setNavRightButton(image: UIImage.init(named: "seachbar")!)
//        self.rightButtonClicked = { btn in
//            let vc = SSSeachViewController()
//            _ = self.navigationController?.pushViewController(vc, animated: true)
//        }
		// Do any additional setup after loading the view.
	}
    func addScrollView(){
      segment = UISegmentedControl(items: ["全部","高频","低频"])
      segment.frame = CGRect(x: 0, y: 0, w: self.view.width, h: 40)
      segment.tintColor = UIColor.seaGreenColor()
      segment.selectedSegmentIndex = 0
      segment.backgroundColor = UIColor.white
      segment.addTarget(self, action: #selector(segmentClick), for: .valueChanged)
      self.view.addSubview(segment)
    }
    func segmentClick(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            cpType = .allCp
            tableView.safeReload()
        case 1:
            cpType = .gpCp
            tableView.safeReload()
        default:
            cpType = .dpCp
            tableView.safeReload()
            
        }
    }
	func requestopenCode(model: SSHomeSSLotteryModel, group: DispatchGroup) {

		let url = "http://api.jisuapi.com/caipiao/history?appkey=3afdff18fac4efeb&&caipiaoid=\(model.caipiaoid!)&&num=1"

		NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .get, parameters: nil) { (status, data) in
			if status == .Success {
				if let jsondata = data {
					let json = jsondata as? JSON
					if json?["status"].stringValue == "0" {
						if let lotteryinfo = json?["result"]["list"].arrayObject {
							lotteryinfo.enumerated().forEach({ (index, lott) in
								let model = SSLotteryJSModel()
								_ = self.JsonMapToObject(JSON: lott, toObject: model)
								model.caipiaoid = (json?["result"]["caipiaoid"].stringValue)!
								self.lotteryinfoArray.append(model)

							})
						}
					}
				}
			}
			group.leave()
		}

	}

	func getopenCode() {
		self.showLoadingView()
		let group = DispatchGroup()
		let myQueue = DispatchQueue.global()

		lotteryArray.enumerated().forEach({ (index, model) in
			group.enter()
			myQueue.async(group: group, qos: .default, flags: [], execute: {

				self.requestopenCode(model: model, group: group)
			})
		})
		group.notify(queue: .main) {
			self.tableView.safeReload()
            self.tableView.endRefreshing()
			self.hideLoadingView()
		

		}

	}
	func getLotteryData() {
		let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
		let dic = NSDictionary(contentsOfFile: path!)
		let array = dic?["data"] as? Array<Any>
		array?.enumerated().forEach({ (index, data) in
			let model = SSHomeSSLotteryModel()
			_ = self.JsonMapToObject(JSON: data, toObject: model)
			lotteryArray.append(model)
		})

	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
    return 1
        
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		
        switch cpType {
        case .allCp:
            return lotteryinfoArray.count
        case .gpCp:
            return gaopingArray.count
        default:
            return dipingArray.count
        }
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SSLotteryTableViewCell
		if cell == nil {
			cell = Bundle.main.loadNibNamed("SSLotteryTableViewCell", owner: self, options: nil)?.first as? SSLotteryTableViewCell
		}
		cell?.selectionStyle = .none
        switch cpType {
        case .allCp:
            if lotteryinfoArray.count > indexPath.section {
                cell?.setModel(model: lotteryinfoArray[indexPath.section])
            }

        case .gpCp:
            if gaopingArray.count > indexPath.section {
                cell?.setModel(model: gaopingArray[indexPath.section])
            }
            
        default:
            if dipingArray.count > indexPath.section {
                cell?.setModel(model: dipingArray[indexPath.section])
            }
        }
		
		return cell!
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cpType {
        case .allCp:
            if lotteryinfoArray.count > indexPath.section {
                let model = lotteryinfoArray[indexPath.section]
                let vc = SSLotteryDetaViewController()
                vc.lotterModel = model
                _ = self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case .gpCp:
            if gaopingArray.count > indexPath.section {
                let model = gaopingArray[indexPath.section]
                let vc = SSLotteryDetaViewController()
                vc.lotterModel = model
                _ = self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
          		if dipingArray.count > indexPath.section {
                    let model = dipingArray[indexPath.section]
                    let vc = SSLotteryDetaViewController()
                    vc.lotterModel = model
                    _ = self.navigationController?.pushViewController(vc, animated: true)
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
