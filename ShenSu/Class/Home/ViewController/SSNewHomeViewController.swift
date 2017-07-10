//
//  SSHomeViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
import EasyPeasy
class NewSSHomeViewController: BaseViewController {
    var homeHraderView: SSHomeHeaderView!
    var bannarArray = Array<SSBannarModel>()
    var collectionView: UICollectionView!
    var lotteryArray = Array<NewSSLotteryModel>()
    var headArray:Array<HomecellModel>{
        let model = HomecellModel(imaegName: "推荐", title: "推荐号码")
        let model1 = HomecellModel(imaegName: "热门", title: "热门彩种")
        return [model,model1]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //		self.automaticallyAdjustsScrollViewInsets = false
        
        addcollectionView()
        getLotteryData()
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addsomecode()
    }
    func addsomecode() {
        let infodic = Bundle.main.infoDictionary
        let appName = infodic?["CFBundleName"] as? String
        self.setNavTitle(title: appName ?? "", font: UIFont.init(name: "AmericanTypewriter-Bold", size: 20)!)
        // Arial-BoldMT
        self.setNavRightButton(image: UIImage.init(named: "seachbar")!)
        self.rightButtonClicked = { btn in
            let vc = SSSeachViewController()
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
        //        self.setNavLeftButton(image: UIImage.init(named: "Categories")!)
        //        self.leftButtonClicked = {btn in
        //            if AppUserData.default.isLogin {
        //                self.showMessage(message: "您已经登录了！")
        //            }else{
        //                self.showSSLoginViewController()
        //            }
        //        }
    }
    func addcollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.backColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SSHomeHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "homeHraderView")
        
        collectionView.register(UINib.init(nibName: "SSHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SSHomeCollectionViewCell")
        collectionView.register(UINib.init(nibName: "SSTjCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SSTjCollectionViewCell")
        collectionView.register(SSHomeMeanViewCell.self, forCellWithReuseIdentifier: "HomeMean")
        collectionView.register(SSHomecellHeadCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "cellhead")
        self.view.addSubview(collectionView)
        
        collectionView <- [
            Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        ]
        collectionView.addRefreshingHeaderView {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.collectionView.endRefreshing()
            })
        }
        
    }
    func getLotteryData() {
        let path = Bundle.main.path(forResource: "LotteryInfo", ofType: "geojson")
        let dic = NSDictionary(contentsOfFile: path!)
        let array = dic?["data"] as? Array<Any>
        array?.enumerated().forEach({ (index, data) in
            let model = NewSSLotteryModel()
            _ = self.JsonMapToObject(JSON: data, toObject: model)
            lotteryArray.append(model)
        })
        self.collectionView.safeReload()
        
    }
    func setBannarData() {
        
        let banner = [
            [
                "AritleUrl": "http://wap.fcaimao.com/userTask/101LotteryRed.jhtml",
                "ImgUrl": "http://img.rrzcp8.cn/rrzcp/product/images/duobao/clientAd/1499074466818_1.jpg"
            ],
            [
                "AritleUrl": "http://touch.fcaimao.com/special/fucai3d/index.html",
                "ImgUrl":"http://img.rrzcp8.cn/rrzcp/product/images/duobao/clientAd/1499049349639_1.png"
            ],
            [
                "AritleUrl": "http://wap.fcaimao.com/userTask/extension.jhtml",
                "ImgUrl": "http://img.rrzcp8.cn/rrzcp/product/images/duobao/clientAd/1499071336604_1.jpg"
            ]
        ]
        var bannars = Array<String>()
        banner.enumerated().forEach({ (index, json) in
            let model = SSBannarModel()
            _ = self.JsonMapToObject(JSON: json, toObject: model)
            bannars.append(model.bannarUrl)
            self.bannarArray.append(model)
        })
        self.homeHraderView.zpbannar.imagePaths = bannars
        
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
extension NewSSHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if lotteryArray.count > indexPath.row && indexPath.section > 0 {
            let model = lotteryArray[indexPath.row]
            let vc = SSHomeWebViewController()
            vc.titleName = model.lot_name
            vc.url = model.lot_url
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: self.view.width, height: 180)
        } else {
            return CGSize(width: self.view.width, height: 40)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader && indexPath.section == 0 {
            homeHraderView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "homeHraderView", for: indexPath) as? SSHomeHeaderView)!
            setBannarData()
        }else if kind == UICollectionElementKindSectionHeader  {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellhead", for: indexPath) as? SSHomecellHeadCollectionReusableView
            view?.setModel(model: headArray[indexPath.section])
            return view!
        }
        return homeHraderView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 2:
            return CGSize(width: self.collectionView.width, height: 123)
        case 0:
            return CGSize(width: self.collectionView.width, height: 80)
        default:
            let width = (self.view.width - 1) / 2
            return CGSize(width: width, height: 80)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            //        case 1:
        //            return 1
        default:
            return lotteryArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSTjCollectionViewCell", for: indexPath) as? SSTjCollectionViewCell
            cell?.homesaveBtnBlock = {
                self.showMessage(message: "保存成功")
            }
            cell?.xuanhaoBtnBlock = {
                let alert = UIAlertController(title: nil, message: "是否打开Safari购彩?", preferredStyle: .alert)
                let defa = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string:"http://m.59cp88.com/index/home")!, options: [:], completionHandler: { (finish) in
                                
                            })
                        } else {
                            UIApplication.shared.openURL(URL(string:"http://m.59cp88.com/index/home")!)
                        }
                    })
                    
                })
                let cancal = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                    
                })
                alert.addAction(defa)
                alert.addAction(cancal)
                self.present(alert, animated: true, completion: nil)
            }
            
            return cell!
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSHomeCollectionViewCell", for: indexPath) as? SSHomeCollectionViewCell
            if lotteryArray.count > indexPath.row {
                cell?.setNewModel(model: lotteryArray[indexPath.row])
            }
            
            return cell!
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMean", for: indexPath) as? SSHomeMeanViewCell
            cell?.homeMeanBlock = { inx in
                switch inx {
                case 1001:
                    let vc = CpMapViewController()
                    _ = self.navigationController?.pushViewController(vc, animated: true)
                case 1002:
                    AVCaptureSessionManager.checkAuthorizationStatusForCamera(grant: {
                        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scanViewController")
                        self.navigationController?.pushViewController(controller, animated: true)
                    }){
                        let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
                            let url = URL(string: UIApplicationOpenSettingsURLString)
                            UIApplication.shared.openURL(url!)
                        })
                        let con = UIAlertController(title: "权限未开启", message: "您未开启相机权限，点击确定跳转至系统设置开启", preferredStyle: UIAlertControllerStyle.alert)
                        con.addAction(action)
                        self.present(con, animated: true, completion: nil)
                    }
                case 1004:
                    let vc = SSZstViewController()
                    _ = self.navigationController?.pushViewController(vc, animated: true)
                default:
                    let vc = SSLotteryViewController()
                    _ = self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return cell!
            
        }
        
    }
}
