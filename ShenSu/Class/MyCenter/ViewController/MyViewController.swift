//
//  MyViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import Kingfisher
struct MycenterModel {
	var iconImage: String!
	var title: String!
	var id: String!
}
class MyViewController: BaseViewController {
	var collectionView: UICollectionView!
	var spacefloat: CGFloat = 5.0
	var imageHeight = UIScreen.main.bounds.width * 1200 / 1920
	var userHeader: UserHeaderCollectionReusableView?
	var dataArray: Array<MycenterModel> {
		let model = MycenterModel(iconImage: "buyhistory", title: "选号记录", id: "0")
		let model1 = MycenterModel(iconImage: "savehistory", title: "收藏历史", id: "1")
		let model2 = MycenterModel(iconImage: "setpush", title: "推送设置", id: "2")
		let model3 = MycenterModel(iconImage: "clean", title: "清理缓存", id: "3")
		let model4 = MycenterModel(iconImage: "help", title: "关于", id: "4")

		return [model, model1, model2, model3, model4]
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		let layout = CustomCollectionViewFlowLayout()
		layout.minimumLineSpacing = spacefloat
		layout.minimumInteritemSpacing = spacefloat
		layout.headerReferenceSize = CGSize(width: self.view.width, height: self.view.width * 1200 / 1920)
		layout.sectionInset = UIEdgeInsets(top: spacefloat, left: spacefloat, bottom: spacefloat, right: spacefloat)
		collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.alwaysBounceVertical = true
		collectionView.register(UINib.init(nibName: "MycenterCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
		collectionView.register(UINib.init(nibName: "UserHeaderCollectionReusableView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
		self.automaticallyAdjustsScrollViewInsets = false
		collectionView.backgroundColor = UIColor.backColor()
		self.view.addSubview(collectionView)
		collectionView <- [
			Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		]
		// Do any additional setup after loading the view.
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.setTransparentNavBar(flag: true)
		self.setNavLeftButton(image: UIImage())
		self.setNavRightButton(image: UIImage(named: "Settings")!)
		self.rightButtonClicked = { btn in
			let vc = SetupViewController()
			_ = self.navigationController?.pushViewController(vc, animated: true)
		}
		userHeader?.reloadModel()
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.setDefaultNavBar()
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
extension MyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.width , height: 48)
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: self.view.width, height: self.view.width * 1200 / 1920)
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray.count
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MycenterCollectionViewCell
		cell?.setModel(model: dataArray[indexPath.row])
		return cell!
	}
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionElementKindSectionHeader {
			userHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? UserHeaderCollectionReusableView
			userHeader?.tapGestureRecognizerBlock = {
				if AppUserData.default.isLogin {
					let vc = MyProfileViewController()
					_ = self.navigationController?.pushViewController(vc, animated: true)
				} else {
					self.showLoginViewController()
				}
			}
			return userHeader!
		}
		return UICollectionReusableView()
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let model = dataArray[indexPath.row]
		switch model.id.toInt() ?? 0 {
		case 0:
			let vc = UserBuyListViewController()
			vc.lotteryType = .lotterSaveTypeBuy
			_ = self.navigationController?.pushViewController(vc, animated: true)

		case 1:
			let vc = UserBuyListViewController()
			vc.lotteryType = .lotterSaveTypeSave
			_ = self.navigationController?.pushViewController(vc, animated: true)
		case 2:
			let vc = LotterypushTableViewController()
			_ = self.navigationController?.pushViewController(vc, animated: true)
			break
		case 3:
			let cache = KingfisherManager.shared.cache
			cache.clearDiskCache() // 清除硬盘缓存
			cache.clearMemoryCache() // 清理网络缓存
			cache.cleanExpiredDiskCache() // 清理过期的，或者超过硬盘限制大小的
			self.showMessage(message: "清理缓存成功")

		case 4:
			let vc = AboutUsViewController()
			_ = self.navigationController?.pushViewController(vc, animated: true)
			break
		default:
			break
		}
	}
}

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {

	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}

	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let collectionView = self.collectionView
		let insets = collectionView?.contentInset
		let offset = collectionView?.contentOffset
		let minY = -((insets?.top)!)

		let attributesArray = super.layoutAttributesForElements(in: rect)
		if offset!.y < minY {
			let headerSize = self.headerReferenceSize
			let deltaY = CGFloat(fabsf(Float((offset?.y)! - CGFloat(minY))))

			for attrs: UICollectionViewLayoutAttributes in attributesArray! {

				if attrs.representedElementKind == UICollectionElementKindSectionHeader {
					var headerRect = attrs.frame
					headerRect.size.height = max(minY, headerSize.height + deltaY)
					headerRect.origin.y = headerRect.origin.y - deltaY
					attrs.frame = headerRect
					break
				}
			}
		}

		return attributesArray
	}

}
