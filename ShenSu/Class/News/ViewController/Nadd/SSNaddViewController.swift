//
//  SSNaddViewController.swift
//  ShenSu
//
//  Created by shensu on 17/7/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import  EasyPeasy
import SwiftyJSON
enum NaddViewType: Int {
    case NaddViewTypeZJ = 0
    case NaddViewTypeZQ
}
class SSNaddViewController: BaseViewController {
    var tableView: UITableView!
    var page = 1
    
    var naddHeadView: SSNaddHeadView!
    var naddArray = Array<SSNaddModel>()
    var naddZJArray = Array<NaddZJMode>()
    var type: NaddViewType! = .NaddViewTypeZJ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        naddHeadView = SSNaddHeadView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 150))
        tableView.tableHeaderView = naddHeadView
        tableView.addRefreshingHeaderView { 
            self.page = 1
            self.getData()
        }
        tableView.addRefreshingFooterView { 
            self.page += 1
            self.getData()
        }
        tableView <- [
        Edges(0)
        ]
        getData()
        getbannar()
        // Do any additional setup after loading the view.
    }
    func getbannar(){
        var bannarArray = Array<SSBannarModel>()
        NetWorkManager.default.rawRequestWithUrl(URLString: "http://mycp.iplay78.com/trade-web/web/client/ads?", method: .post, parameters: [
            "lot_list": [
                "channel_cd": "Apple",
                "app_cd": "com.zscp.lot16",
                "access_token": ""
            ],
            "c_head": [
                "client_id": "BY003000000000000002",
                "client_os": "IOS"
            ]
        ]) { (status, data) in
            if status == .Success {
                if let jsondata = data {
                    let json = JSON(jsondata)
                    if let dic = json["lot_list"].dictionaryObject {
                        if let array = dic["data"] as? Array<Dictionary<String,Any>> {
                            array.enumerated().forEach({ (index, obj) in
                                let model = SSBannarModel()
                                model.bannarUrl = "http://mycp.iplay78.com\(obj["ads_url"]!)"
                                model.openUrl = obj["a_forward_html"] as? String ?? ""
                                bannarArray.append(model)
                                
                            })
                            self.naddHeadView.bannarArray = bannarArray
                        }
                    }
                }
            }
            
            
        }

    
    }
    
    
    func getData(){
        
        NetWorkManager.default.rawRequestWithUrl(URLString: "http://mycp.iplay78.com/trade-web/web/lottery/winners/list?", method: .post, parameters: [
            "winner_list": [
                "page_index": "\(page)",
                "page_size": "20"
            ],
            "c_head": [
                "client_id": "BY003000000000000002",
                "client_os": "IOS"
            ]
        ]) { (status, data) in
            self.tableView.endRefreshing()
            if status == .Success {
                if let jsondata = data {
                    let json = JSON(jsondata)
                    if let dic = json["winner_list"].dictionaryObject {
                        if let array = dic["data"] as? Array<Dictionary<String,String>> {
                            if self.page == 1 {
                            self.naddZJArray.removeAll()
                            }
                           array.enumerated().forEach({ (index,obj) in
                           
                                let model = NaddZJMode()
                                _ = self.JsonMapToObject(JSON: obj, toObject: model)
                                self.naddZJArray.append(model)
                            
                           })
                             self.tableView.safeReload()
                        }
                    
                    }
                
                }
            
            
            
            }
            
            
        }
        
        
        NetWorkManager.default.rawRequestWithUrl(URLString: "http://mycp.iplay78.com/trade-web/web/article_list?", method: .post, parameters: [
            "article_list": [
                "category_code": "1",
                "page_index": page - 1 ,
                "page_size": 20
            ],
            "c_head": [
                "client_id": "BY003000000000000002",
                "client_os": "IOS"
            ]
        ]
        ) { (status, data) in
            self.tableView.endRefreshing()
            if status == .Success {
                if let jsondata = data {
                    let json = JSON(jsondata)
                    if let dic = json["article_list"].dictionaryObject {
                        if let array = dic["comm_article"] as? Array<Dictionary<String,Any>> {
                            if self.page == 1 {
                                self.naddArray.removeAll()
                            }
                            array.enumerated().forEach({ (index,obj) in
                                let model = SSNaddModel()
                                _ = self.JsonMapToObject(JSON: obj, toObject: model)
                                self.naddArray.append(model)
                            })
                        }
                        
                    }
                    
                }
                
                
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
extension SSNaddViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .NaddViewTypeZJ{
        return naddZJArray.count
        }else{
         return naddArray.count
        }
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .NaddViewTypeZJ {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SSNaddZJTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("SSNaddZJTableViewCell", owner: self, options: nil)?.first as? SSNaddZJTableViewCell
            }
            if naddZJArray.count > indexPath.row {
                cell?.setModel(model: naddZJArray[indexPath.row])
            }
            cell?.selectionStyle = .none
            return cell!

        
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SSNaddTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("SSNaddTableViewCell", owner: self, options: nil)?.first as? SSNaddTableViewCell
            }
            if naddArray.count > indexPath.row {
                cell?.setModel(model: naddArray[indexPath.row])
            }
            cell?.selectionStyle = .none
            return cell!

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let head = SSNaddSectionHeadView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 44))
        head.index = type.rawValue
        head.segumentClickBlock = { [weak self] index in
            if index == 0 {
            self?.type = .NaddViewTypeZJ
            }else{
            self?.type = .NaddViewTypeZQ
            }
            self?.tableView.reloadData()
        }
      return head
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SSHomeWebViewController()
        if type == .NaddViewTypeZJ{
        vc.url = naddZJArray[indexPath.row].w_info_absolute_url
        vc.titleName = "大奖喜讯"
        }else{
        vc.url = naddArray[indexPath.row].article_detail_url
        vc.titleName = "彩票资讯"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
