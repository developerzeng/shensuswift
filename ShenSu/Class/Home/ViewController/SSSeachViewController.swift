//
//  SSSeachViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/12.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON
class SSSeachViewController: BaseViewController {
    var seachBar: UISearchBar!
    var tableView: UITableView!
    var dataArray = Array<Dictionary<String,String>>()
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppUserData.default.lotteryClass != nil {
            dataArray = AppUserData.default.lotteryClass!
        }
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removfootViewLine()
        self.view.addSubview(tableView)
        tableView <- [
        Edges(0)
        ]
        if AppUserData.default.lotteryClass == nil {
        setData()
        }
        
        
        // Do any additional setup after loading the view.
    }

    func setData(){
       self.showLoadingView()
        NetWorkManager.default.rawRequestWithUrl(URLString: "http://api.jisuapi.com/caipiao/class?appkey=3afdff18fac4efeb") { (status, data) in
            self.hideLoadingView()
            if status == .Success {
                if let jsondata = data {
                let json =   JSON(jsondata)
                    if let dic = json["result"].arrayObject {
                     AppUserData.default.lotteryClass = dic as? Array<Dictionary<String,String>>
                     self.dataArray = AppUserData.default.lotteryClass!
                    }
                    self.tableView.safeReload()
                }
            }else{
            self.showMessage(message: "加载彩票类型出错")
            }
            
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        seachBar = UISearchBar()
        seachBar.placeholder = "查询开奖结果"
        seachBar.barStyle = .default
        seachBar.delegate = self
        seachBar.frame = CGRect(x: 0, y: 0, w: self.view.width - 80, h: 30)
        self.navigationItem.titleView = seachBar
        
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
extension SSSeachViewController: UISearchBarDelegate , UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seachBar.endEditing(true)
        if dataArray.count > indexPath.row {
        let vc = SSSeachOpenViewController()
            vc.lotteryDic = dataArray[indexPath.row]
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataArray[indexPath.row]["name"]
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        
        return cell!
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        seachBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        seachBarDidChangeForArray()
        if seachBar.text?.isEmpty == true {
            if AppUserData.default.lotteryClass != nil {
                dataArray = AppUserData.default.lotteryClass!
            }
            self.tableView.safeReload()
        }

    }
    func seachBarDidChangeForArray(){
     var newArray = Array<Dictionary<String,String>>()
        for dic in dataArray {
            if dic["name"]!.contains(seachBar.text ?? "") == true {
             newArray.append(dic)
            }
        }
     dataArray = newArray
     self.tableView.safeReload()
    }
}
