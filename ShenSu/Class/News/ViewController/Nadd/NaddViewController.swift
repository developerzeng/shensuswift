//
//  NaddViewController.swift
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
class NaddViewController: BaseViewController {
    var tableView: UITableView!
    var naddHeadView: NaddHeadView!
    var naddArray = Array<NaddModel>()
    var naddZJArray = Array<NaddZJMode>()
    var type: NaddViewType! = .NaddViewTypeZJ
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        naddHeadView = NaddHeadView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 150))
        tableView.tableHeaderView = naddHeadView
        
        tableView <- [
        Edges(0)
        ]
        getData()
        // Do any additional setup after loading the view.
    }
    func getData(){
   

  var bannarArray = Array<BannarModel>()
  let array = [["ImgUrl":"http://mycp.iplay78.com/res/activity/5016ae21-1641-4375-9d43-bb417c370ebb.jpg","AritleUrl":"http://mycp.iplay78.com/info/7c494511fe2440efa0205f9cc43e0699.html"],
                 ["ImgUrl":"http://mycp.iplay78.com/res/activity/766fc1aa-567b-450e-b731-f0456173e8fb.jpg","AritleUrl":"http://mycp.iplay78.com/info/edb6fcf3901245d382f2f5fd20ff027b.html"],
                 ["ImgUrl":"http://mycp.iplay78.com/res/activity/4bc368ab-e546-4341-ac53-bb2e5d4ff06e.jpg","AritleUrl":"http://mycp.iplay78.com/info/6a49244d750143c09f9ecd155bef78ab.html"],
                 ["ImgUrl":"http://mycp.iplay78.com/res/activity/4bb682c5-6337-4e7a-a758-68589c63d39b.jpg"],
                 ["ImgUrl":"http://mycp.iplay78.com/res/activity/7412cffc-992c-48e0-9f8d-99266700fb31.jpg"],
                 ["ImgUrl":"http://mycp.iplay78.com/res/activity/cd01d8a2-2512-42b8-b3ea-1ff8cd4aab34.jpg"]]
        
        
  array.enumerated().forEach { (index,data) in
   let model = BannarModel()
   _ =  self.JsonMapToObject(JSON: data, toObject: model)
   bannarArray.append(model)
   }
   naddHeadView.bannarArray = bannarArray
    
   let path = Bundle.main.path(forResource: "NaddNews", ofType: "geojson")
   let str = try? NSString.init(contentsOfFile: path!, encoding: 4)
   
   let dic = try? JSONSerialization.jsonObject(with: (str!.data(using: 4))!, options: .mutableContainers) as? Dictionary<String,Any>
   let narray = dic??["comm_article"] as? Array<Any>
   narray?.enumerated().forEach({ (index, data) in
            let model = NaddModel()
            _ = self.JsonMapToObject(JSON: data, toObject: model)
            naddArray.append(model)
    })
   
    let narrayzj = dic??["data"] as? Array<Any>
    narrayzj?.enumerated().forEach({ (index, data) in
            let model = NaddZJMode()
            _ = self.JsonMapToObject(JSON: data, toObject: model)
            naddZJArray.append(model)
    })
    self.tableView.safeReload()
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
extension NaddViewController : UITableViewDelegate, UITableViewDataSource {
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
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NaddZJTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("NaddZJTableViewCell", owner: self, options: nil)?.first as? NaddZJTableViewCell
            }
            if naddArray.count > indexPath.row {
                cell?.setModel(model: naddZJArray[indexPath.row])
            }
            cell?.selectionStyle = .none
            return cell!

        
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NaddTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("NaddTableViewCell", owner: self, options: nil)?.first as? NaddTableViewCell
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
      let head = NaddSectionHeadView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 44))
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
        let vc = HomeWebViewController()
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
