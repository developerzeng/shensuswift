//
//  LotteryDetaViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON

class SeachOpenViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var lotteryDic:Dictionary<String,String>!
    var lotteryinfoArray = Array<LotteryJSModel>()
    var lotteryTypeArray = Array<HomeLotteryModel>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title: "\(lotteryDic["name"]!)历史开奖")
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.removfootViewLine()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView <- [
            Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        ]
        self.tableView.addRefreshingHeaderView {
            self.setCPData()
        }
     
        setCPData()

    }
       func setCPData() {
        self.showLoadingView()
        let url = "http://api.jisuapi.com/caipiao/history?appkey=3afdff18fac4efeb&&caipiaoid=\(lotteryDic["caipiaoid"]!)&&num=20"
        
        NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .get, parameters: nil) { (status, data) in
            self.tableView.endRefreshing()
            self.hideLoadingView()
            if status == .Success {
                self.lotteryinfoArray.removeAll()
                if let jsondata = data {
                    let json = jsondata as? JSON
                    if json?["status"].stringValue == "0" {
                        if let lotteryinfo = json?["result"]["list"].arrayObject {
                            lotteryinfo.enumerated().forEach({ (index, lott) in
                                let model = LotteryJSModel()
                                _ = self.JsonMapToObject(JSON: lott, toObject: model)
                                self.lotteryinfoArray.append(model)
                            })
                            self.tableView.addFugaiView(force: false)
                            self.tableView.safeReload()
                        }else{
                        self.showMessage(message: "暂无开奖数据", delay: 1.0)
                           
                        self.tableView.addFugaiView(force: true)
                           
                        }
                    } else {
                        self.showMessage(message: json?["msg"].stringValue ?? "")
                        self.tableView.addFugaiView(force: true)
                    }
                    
                }
            } else {
                self.showMessage(message: "加载失败....")
            }
        }
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
     
        return lotteryinfoArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LotteryDetaTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("LotteryDetaTableViewCell", owner: self, options: nil)?.first as? LotteryDetaTableViewCell
        }
        cell?.selectionStyle = .none
        if lotteryinfoArray.count > indexPath.row {
            cell?.isfirst = indexPath.row == 0 ? true : false
            cell?.setModel(model: lotteryinfoArray[indexPath.row])
        }
        return cell!
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
