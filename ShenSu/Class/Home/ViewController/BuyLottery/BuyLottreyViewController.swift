//
//  BuyLottreyViewController.swift
//  ShenSu
//
//  Created by shensu on 17/5/23.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyJSON

class BuyLottreyViewController: BaseViewController {
	var lotteryData: Array<ruleModel>? {
		didSet {
			lotteryData?.enumerated().forEach({ (index, rule) in
				var classArray = Array<BuyLotteryModel>()
				let min = Int(rule.Nmin) ?? 0
				let max = Int(rule.Nmax) ?? 0
				for i in min...max {
					let model = BuyLotteryModel()
					model.number = i.toString
					model.isChoose = false
					classArray.append(model)
				}
				selectedArray.append(Array<BuyLotteryModel>())
				dataArray.append(classArray)
			})

		}
	}
    var lotterydeta = LotteryDetaView()
	var qishu: String = ""
	var lotteryinfoArray = Array<LotteryModel>()
	var url: String!
    var caipiaoid: String!
	var isChoose: Bool = false
	var titleName: String? {
		didSet {
			self.setNavTitle(title: titleName!)
		}
	}
    var lotteryInfoModel: HomeLotteryModel!{
        didSet{
        self.url = lotteryInfoModel.url
        self.caipiaoid = lotteryInfoModel.caipiaoid
        self.titleName = lotteryInfoModel.name
        self.lotteryData = lotteryInfoModel.rule
        }
     
    }
	var buyListModels = Array<LotteryListModel>()
	var buyNumber: String = ""
	var buyViewHeaderView: BuyViewHeaderView!
	var footerView: BuyLotteryFooterView!
	var selectedArray = Array<Array<BuyLotteryModel>>()
	var collevtionView: UICollectionView!
	var insetspace: CGFloat = 10.0
	var dataArray = Array<Array<BuyLotteryModel>>()
	override func viewDidLoad() {
		super.viewDidLoad()
		addBuyViewHeaderView()
		addCollectionView()
		setCPData()
		self.setNavRightButtonTitle(title: "详细")
		UIApplication.shared.applicationSupportsShakeToEdit = true
		self.becomeFirstResponder()
		self.rightButtonClicked = { [weak self] btn in
            let sender = btn as? UIButton
            sender?.isSelected = !(sender?.isSelected)!
            self?.lotterydeta.removeFromeSuperViewBlock = {
            self?.lotterydeta.removeFromSuperview()
            sender?.isSelected  = false
            }
            self?.lotterydeta.selectRowBlock = {index in
                self?.lotterydeta.removeFromSuperview()
                sender?.isSelected  = false
                switch index.row {
                case 0:
                    let vc = UserBuyListViewController()
                    vc.lotteryType = .lotterSaveTypeBuy
                    _ = self?.navigationController?.pushViewController(vc, animated: true)
                case 1:
                    let vc = LotteryRuleViewController()
                    vc.talk = self?.lotteryInfoModel.talk
                    _ = self?.navigationController?.pushViewController(vc, animated: true)
                default:
                    let model = LotteryJSModel()
                    model.caipiaoid = (self?.caipiaoid)!
                    let vc = LotteryDetaViewController()
                    vc.lotterModel = model
                    _ = self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            if sender?.isSelected == true {
                self?.lotterydeta.frame = (self?.view.bounds)!
                self?.view.addSubview((self?.lotterydeta)!)
            }else{
                self?.lotterydeta.removeFromSuperview()
            }
    
            
//			let button = btn as? UIButton
//			button?.isEnabled = false
//			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//				button?.isEnabled = true
//			})
//			self?.moveiphone()
		}
	}
	func addBuyViewHeaderView() {
		buyViewHeaderView = BuyViewHeaderView()
		self.view.addSubview(buyViewHeaderView)
		buyViewHeaderView <- [
			Top().to(self.view, .top),
			Left().to(self.view, .left),
			Right().to(self.view, .right),
			Height(self.view.height / 2)
		]
	}
	func removeSelected() {
		for i in 0..<selectedArray.count {
			for buymodel in selectedArray[i] {
				buymodel.isChoose = false
			}
			selectedArray[i].removeAll()
		}
		self.collevtionView.reloadData()
	}
	func moveiphone() {
		var array = Array<String>()
		removeSelected()
		lotteryData?.enumerated().forEach({ (index, rule) in
			array = randomModel.default.setRandomfrom(fromNumber: rule.Nmin.toInt()!, toNumber: rule.Nmax.toInt()!, red: rule.Cmin.toInt()!)!

			array.enumerated().forEach({ (clindex, x) in
				self.collectionView(collevtionView, didSelectItemAt: IndexPath(row: x.toInt()!, section: index))
			})
		})
	}
	/**
     加载开奖
     */
	func setCPData() {
		self.showLoadingView()
		NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .post, parameters: nil) { (status, data) in
			if status == .Success {
				self.hideLoadingView()
				self.lotteryinfoArray.removeAll()
				if let jsondata = data {
					let json = jsondata as? JSON
					if let lotteryinfo = json?["data"].arrayObject {
						lotteryinfo.enumerated().forEach({ (index, lott) in

							let model = LotteryModel()
							_ = self.JsonMapToObject(JSON: lott, toObject: model)
							if index == 0 {
								self.qishu = "\(model.expect.toInt()! + 1)"
							}
							self.lotteryinfoArray.append(model)
						})
						self.buyViewHeaderView.lotteryinfoArray = self.lotteryinfoArray
					}

				}
			}
		}
	}
	override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
		return
	}
	override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
		if event?.subtype == .motionShake {
			moveiphone()
		}
		return
	}
	func addCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = insetspace
		layout.minimumInteritemSpacing = insetspace
		layout.itemSize = CGSize(width: 40, height: 40)
		layout.sectionInset = UIEdgeInsets(top: insetspace, left: 2 * insetspace, bottom: 2 * insetspace, right: 2 * insetspace)
		collevtionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collevtionView.delegate = self
		collevtionView.dataSource = self
		collevtionView.alwaysBounceVertical = true
		collevtionView.backgroundColor = UIColor.white
		collevtionView.register(BuyLottreyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collevtionView.register(BuyLotteryHeardCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
		self.view.addSubview(collevtionView)
		collevtionView <- [
			Edges(UIEdgeInsets(top: 30, left: 0, bottom: 50, right: 0))
		]

		footerView = BuyLotteryFooterView()
		self.view.addSubview(footerView)
		footerView.clearBtnBlock = { [weak self] in
	
			self?.removeSelected()
		}
		footerView.goBtnBlock = { [weak self] in

			if self?.isChoose == true && self?.qishu.isEmpty == false {
				var lotteryNumber = ""
				self?.selectedArray.enumerated().forEach({ (index, array) in
					array.enumerated().forEach({ (inx, model) in
						lotteryNumber.append("\(model.number)|")
					})
				})
				let model = LotteryListModel()
				model.lotteryType = (self?.titleName)!
				model.lotteryNumber = lotteryNumber.substring(to: lotteryNumber.index(lotteryNumber.startIndex, offsetBy: lotteryNumber.length - 1))
				model.lotteryCount = (self?.buyNumber)!
				model.lotteryExpect = (self?.qishu)!
				let vc = BuyListViewController()
				self?.buyListModels.append(model)
				vc.lotteryArray = (self?.buyListModels)!
				vc.buyListdelegate = self
				_ = self?.navigationController?.pushViewController(vc, animated: true)

			} else {
				if self?.qishu.isEmail == true {
					self?.showMessage(message: "期数获取失败")
				} else {
					self?.showMessage(message: "您未正确选择号码")
				}

			}
		}
		footerView <- [
			Bottom().to(self.view, .bottom),
			Left().to(self.view, .left),
			Right().to(self.view, .right),
			Height(50)
		]
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
extension BuyLottreyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BuyListreloadData {
	func reloadDataModels(models: Array<LotteryListModel>) {
		buyListModels = models
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: self.view.width, height: 40)
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return dataArray.count
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray[section].count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collevtionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BuyLottreyCollectionViewCell
		if dataArray.count > indexPath.section && dataArray[indexPath.section].count > indexPath.row {
			cell?.setModel(model: dataArray[indexPath.section][indexPath.row])
		}
		return cell!
	}
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as? BuyLotteryHeardCollectionReusableView
		view?.setLableText(text: "最少选择\(lotteryData![indexPath.section].Cmin!)个球")
		return view!

	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let model = dataArray[indexPath.section][indexPath.row]
		model.isChoose = !model.isChoose
		collevtionView.reloadItems(at: [indexPath])
		if model.isChoose == true {
			selectedArray[indexPath.section].append(model)
		} else {
			if selectedArray[indexPath.section].contains(items: model) {
				selectedArray[indexPath.section].removeObject(object: model)
			}
		}
		let number = SSQbuyNumber()
		buyNumber = number.toString
		isChoose = number > 0 ? true : false
		footerView.setNumber(number: number.toString)
	}

	func SSQbuyNumber() -> Int {
		var sum = 1
		for i in 0..<lotteryData!.count {
			let classC = selectedArray[i].count
			let modelC = lotteryData?[i].Cmin.toInt()!
			if classC >= modelC! {
				sum *= classC.factorial() / ((classC - modelC!).factorial() * modelC!.factorial())
			} else {
				return 0
			}
		}
		return sum
	}
	func scrollViewDidScroll(_ scrollView: UIScrollView) {

		let y = scrollView.contentOffset.y
		let rect = collevtionView.frame
		if y < 0 && rect.y < self.view.height / 2 {
			collevtionView.frame = CGRect(x: rect.x, y: rect.y - y, w: rect.width, h: rect.height)
		} else if rect.y > self.view.height / 2 {
			collevtionView.frame = CGRect(x: rect.x, y: self.view.height / 2, w: rect.width, h: rect.height)
		} else if y > 0 && rect.y > 30 {
			collevtionView.frame = CGRect(x: rect.x, y: rect.y - y, w: rect.width, h: rect.height)
		} else if rect.y < 30 {
			collevtionView.frame = CGRect(x: rect.x, y: 30, w: rect.width, h: rect.height)
		}
		self.view.bringSubview(toFront: collevtionView)
	}

}
