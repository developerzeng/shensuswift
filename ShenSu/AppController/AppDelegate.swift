//
//  AppDelegate.swift
//  ShenSu
//
//  Created by shensu on 17/5/9.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import SwiftyJSON
import EasyPeasy
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, JPUSHRegisterDelegate {

	var window: UIWindow?
	var launchScreen: UIImageView?
	var manager: NetworkReachabilityManager?
	var viewController: ViewController?
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Bmob.register(withAppKey: "a4da0bcecaa6f88d832cb31b8bacea4e")
        observeNetWork()
		self.window?.frame = UIScreen.main.bounds
		AMapServices.shared().apiKey = AppNeedKey().GDMapKey
		UIApplication.shared.statusBarStyle = .lightContent
		window?.frame = UIScreen.main.bounds
		window?.rootViewController = MainViewController()
		window?.makeKeyAndVisible()
		windowsAddLaunchScreen()
		addPush(application: application, launchOptions: launchOptions)
        if launchOptions != nil {
        let dic = launchOptions?[.remoteNotification]
            if dic != nil {
            let userDefault = UserDefaults.standard
                let aps = JSON(dic!).dictionaryObject
                userDefault.set(aps, forKey: "pushMessage")
                userDefault.synchronize()
            }
        }

		return true
	}
	func addPush(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
		UMessage.start(withAppkey: AppNeedKey().UMkey, launchOptions: launchOptions)
		UMessage.registerForRemoteNotifications()
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()

			center.delegate = self

			let typers10: UNAuthorizationOptions = [.badge, .alert, .sound]
			center.requestAuthorization(options: typers10) { (granted, error) in
				if granted {
                    
				} else {

				}
			}
		} else {
			// Fallback on earlier versions
		}

		let entity = JPUSHRegisterEntity()
		if #available(iOS 10.0, *) {
			let types: UNAuthorizationOptions = [.alert, .badge, .sound]
			entity.types = Int(types.rawValue)
			if UIDevice.current.systemName.toFloat() ?? 0 >= 8.0 {
			}
		} else {
			// Fallback on earlier versions
		}

		JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
		JPUSHService.setup(withOption: launchOptions, appKey: AppNeedKey().JpushKey, channel: "App Store", apsForProduction: true)
	}
	func addActionInfo() {
    //    let bundleid = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        let query:BmobQuery = BmobQuery(className: "Config")
        query.findObjectsInBackground { (array, error) in
          array?.enumerated().forEach({ (index,classdata) in
            let obj = classdata as! BmobObject
            let appid = obj.object(forKey: "appid") as? String ?? ""
            let url = obj.object(forKey: "url") as? String ?? ""
            let show = obj.object(forKey: "show") as? Bool ?? false
            if appid.replacingOccurrences(of: "\n", with: "") == "com.xmbjsc.xmbjsc" {
                DispatchQueue.main.async {
                    if show == true {
                        let isfirst = UserDefaults.standard.value(forKey: "dhGuidePage")
                        if isfirst != nil {
                            let vc = LQKGeneralWebViewController()
                            vc.url = URL(string:url.replacingOccurrences(of: "\n", with: ""))
                            self.window?.rootViewController = vc
                            self.window?.makeKeyAndVisible()
                            self.removeLaunchScreenView()
                        }else{
                            let dh = DHMainViewController()
                            dh.isremoveFromWindows = {
                                let vc = LQKGeneralWebViewController()
                                vc.url = URL(string:url.replacingOccurrences(of: "\n", with: ""))
                                self.window?.rootViewController = vc
                                self.window?.makeKeyAndVisible()
                                self.removeLaunchScreenView()
                            }
                            self.window?.rootViewController = dh
                            self.window?.makeKeyAndVisible()
                            self.removeLaunchScreenView()
                        }
                        
                    }else{
                        self.removeLaunchScreenView()
                    }
                }
            
            }
          })
         
        }
       

	}
	func windowsAddLaunchScreen() {

		launchScreen = UIImageView()
		launchScreen?.image = UIImage(named: "LaunchImage")
		launchScreen?.frame = (self.window?.frame)!
		self.window?.addSubview(launchScreen!)

	}
	func removeLaunchScreenView() {
		UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
			self.launchScreen?.alpha = 0
			self.launchScreen?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
		}) { (finish) in
			self.launchScreen?.removeFromSuperview()
		}

	}
    func observeNetWork() {
        self.manager = NetworkReachabilityManager(host: "www.baidu.com")
        self.manager?.listener = { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable {
            } else if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown {
            } else {
                self.addActionInfo()
            }
            
            print("Network Status Changed: \(status)")
        }
        self.manager?.startListening()
    }
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		JPUSHService.registerDeviceToken(deviceToken)
	}
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		UMessage.didReceiveRemoteNotification(userInfo)
		JPUSHService.handleRemoteNotification(userInfo)
        
    
      
        let userDefault = UserDefaults.standard
        userDefault.set(userInfo, forKey: "pushMessage")
        userDefault.synchronize()
        
        
		completionHandler(.newData)
	}
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
		JPUSHService.handleRemoteNotification(userInfo)
	}
	@available(iOS 10.0, *)
	func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
		let userinfo = notification.request.content.userInfo
		if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
			JPUSHService.handleRemoteNotification(userinfo)
		}

		let types: UNAuthorizationOptions = [.alert, .badge, .sound]

		completionHandler(Int(types.rawValue))
	}

	@available(iOS 10.0, *)
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		let userinfo = notification.request.content.userInfo

		if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
			UMessage.setAutoAlert(true)
			UMessage.didReceiveRemoteNotification(userinfo)
		} else {
		}

		completionHandler([.sound, .badge, .alert])
	}
	@available(iOS 10.0, *)
	func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
		let userinfo = response.notification.request.content.userInfo
        let userDefault = UserDefaults.standard
        let aps = userinfo["aps"]!
        let dic = JSON(aps).dictionaryObject
        userDefault.set(dic, forKey: "pushMessage")
        userDefault.synchronize()
		if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
			JPUSHService.handleRemoteNotification(userinfo)
		}

		completionHandler()
	}

	@available(iOS 10.0, *)
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		let userinfo = response.notification.request.content.userInfo

		if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
			UMessage.didReceiveRemoteNotification(userinfo)
		} else {
		}

	}
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}

