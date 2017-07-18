//
//  MainViewController.swift
//  YunGou
//
//  Created by Apple on 16/5/17.
//  Copyright © 2016年 bangma. All rights reserved.
//

import UIKit

struct MainViewModel {
	var title: String

	var selectImage: UIImage?

	var defaultImage: UIImage?
}

class MainViewController: UITabBarController, UITabBarControllerDelegate {

	var models = Array<MainViewModel>()

	override func viewDidLoad() {
		super.viewDidLoad()
        self.tabBar.backgroundColor = UIColor.white
		self.delegate = self
		initData()
		setup()

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	func setup() {
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .selected)
		self.models.enumerated().forEach { (index, model) in
			let vc: UIViewController
			switch index {
			case 0:
				vc = SSNewHomeViewController()
			case 1:
				vc = SSSliderHKTimeViewController()
			case 2:
				vc = SSNaddViewController()
			case 3:
				vc = SSMyViewController()
			default:
				vc = UIViewController()
			}

			let nvc = NavViewController(rootViewController: vc)
			vc.title = model.title
			if index == 0 {
				vc.setNavTitle(title: model.title, color: UIColor.white)
			} else {
				if index != 4 {
					vc.setNavTitle(title: model.title)
				}
			}
			vc.tabBarItem.selectedImage = model.selectImage?.withRenderingMode(.alwaysOriginal)
			vc.tabBarItem.image = model.defaultImage?.withRenderingMode(.alwaysOriginal)
			self.addChildViewController(nvc)
		}
        
        
	}

	func initData() {
		let model1 = MainViewModel(title: "大厅", selectImage: UIImage(named: "sehome"), defaultImage: UIImage(named: "homei"))
		let model2 = MainViewModel(title: "社区", selectImage: UIImage(named: "selottery"), defaultImage: UIImage(named: "lottery"))
		let model3 = MainViewModel(title: "彩票资讯", selectImage: UIImage(named: "sezixun"), defaultImage: UIImage(named: "zixun"))
		let model4 = MainViewModel(title: "我的", selectImage: UIImage(named: "semy"), defaultImage: UIImage(named: "my"))
		self.models.append(contentsOf: [model1,  model2 ,  model3, model4])
	}


    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let vc = viewController as? NavViewController , vc.topViewController != nil {
            if vc.topViewController?.isKind(of: SSMyViewController.self) == true && !AppUserData.default.isLogin {
                self.showLoginViewController()
                return false
            }
        }
        return true

    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
