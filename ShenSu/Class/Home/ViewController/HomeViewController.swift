//
//  HomeViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
import EasyPeasy
class HomeViewController: BaseViewController {
	var homeHraderView: HomeHeaderView!
	var bannarArray = Array<BannarModel>()
	var collectionView: UICollectionView!
	var lotteryArray = Array<HomeLotteryModel>()
	override func viewDidLoad() {
		super.viewDidLoad()
//		self.automaticallyAdjustsScrollViewInsets = false
		self.setNavLeftButton(image: UIImage.init(named: "Categories")!)
		self.leftButtonClicked = { btn in
			if AppUserData.default.isLogin {
				self.showMessage(message: "您已经登录了！")
			} else {
				self.showLoginViewController()
			}
		}
		addcollectionView()
		getLotteryData()

	}
	func addcollectionView() {

		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 5
		layout.minimumInteritemSpacing = 5
		layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collectionView.backgroundColor = UIColor.backColor()
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.register(HomeHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "homeHraderView")

		collectionView.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
		collectionView.register(UINib.init(nibName: "TjCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TjCollectionViewCell")
		self.view.addSubview(collectionView)

		collectionView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0))
		]

	}
	func getLotteryData() {
		let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
		let dic = NSDictionary(contentsOfFile: path!)
		let array = dic?["data"] as? Array<Any>
		array?.enumerated().forEach({ (index, data) in
			let model = HomeLotteryModel()
			_ = self.JsonMapToObject(JSON: data, toObject: model)
			lotteryArray.append(model)
		})
		self.collectionView.safeReload()

	}
	func setBannarData() {

		let banner = [
			[
				"AritleUrl": "http://wap.fcaimao.com/userTask/101LotteryRed.jhtml",
				"ImgUrl": "http://client.fcaimao.com/images/adimg/2017/05/27/1495863328975.jpg"
			],
			[
				"AritleUrl": "http://touch.fcaimao.com/special/fucai3d/index.html",
				"ImgUrl": "http://client.fcaimao.com/images/adimg/2017/05/18/1495097040051.jpg"
			],
			[
				"AritleUrl": "http://wap.fcaimao.com/userTask/extension.jhtml",
				"ImgUrl": "http://client.fcaimao.com/images/adimg/2016/05/13/1463139669836.png"
			]
		]
		var bannars = Array<String>()
		banner.enumerated().forEach({ (index, json) in
			let model = BannarModel()
			_ = self.JsonMapToObject(JSON: json, toObject: model)
			bannars.append(model.bannarUrl)
			self.bannarArray.append(model)
		})
        self.homeHraderView.bannarArray = self.bannarArray
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
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if lotteryArray.count > indexPath.row && indexPath.section > 0 {
			let model = lotteryArray[indexPath.row]
			let vc = BuyLottreyViewController()
			vc.lotteryData = model.rule
			vc.titleName = model.name
			vc.url = model.url
			_ = self.navigationController?.pushViewController(vc, animated: true)
		}

	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		if section == 0 {
			return CGSize(width: self.view.width, height: 180)
		} else {
			return CGSize.zero
		}

	}
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionElementKindSectionHeader && indexPath.section == 0 {
			homeHraderView = (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "homeHraderView", for: indexPath) as? HomeHeaderView)!
			homeHraderView.openBananrUrl = { url in
				let vc = WebViewController()
				vc.url = url 
				_ = self.navigationController?.pushViewController(vc, animated: true)
                
			}
			setBannarData()
		}
		return homeHraderView
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch indexPath.section {
		case 0:
			return CGSize(width: self.collectionView.width, height: 68)
		default:
			let width = (self.view.width - 15) / 2
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
		default:
			return lotteryArray.count
		}
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.section == 0 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TjCollectionViewCell", for: indexPath) as? TjCollectionViewCell
			cell?.homesaveBtnBlock = {
				self.showMessage(message: "保存成功")
			}

			return cell!
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
			if lotteryArray.count > indexPath.row {
				cell?.setModel(model: lotteryArray[indexPath.row])
			}
			return cell!

		}

	}
}
