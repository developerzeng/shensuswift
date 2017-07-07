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
    var isChina:Bool = false
    var appinfo =  Dictionary<String , Any>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.frame = UIScreen.main.bounds
        AMapServices.shared().apiKey = AppNeedKey().GDMapKey
        UIApplication.shared.statusBarStyle = .lightContent
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        windowsAddLaunchScreen()
        observeNetWork()
        addPush(application: application, launchOptions: launchOptions)
        
        return true
    }
    func addPush(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        let um =  UMAnalyticsConfig.sharedInstance()
        um?.appKey = AppNeedKey().UMkey
        um?.channelId = "App Strore"
        MobClick.start(withConfigure: um)
        
        
        
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
        let group = DispatchGroup()
        let myQueue = DispatchQueue.global()
        group.enter()
        myQueue.async(group: group, qos: .default, flags: []) {
            
            NetWorkManager.default.rawRequestWithUrl(URLString: "http://ip.taobao.com/service/getIpInfo.php?ip=myip") { (status, data) in
                if status == .Success {
                    if let datajson = data {
                    let json = datajson as? JSON
                        if let dic = json?["data"].dictionaryObject {
                            if let ad =  dic["country_id"] as? String , ad == "CN" {
                            self.isChina = true
                            }
                        }
                    }
                }
              group.leave()
            }
        }
        group.enter()
        myQueue.async(group: group, qos: .default, flags: []) { 
            NetWorkManager.default.requestAppinfo { (status, data) in
                if status == .Success {
                    if let datajson = data {
                        let json = datajson as? JSON
                        if let dic = json?["data"][0].dictionaryObject {
                        self.appinfo = dic
                        }
                    }
                } else {
                    
                }
                group.leave()
            }
 
        }
        group.notify(queue: .main) { 
            if self.isChina && self.appinfo["statuscode"] as? String == "1" {
                let vc = WKWebViewController()
                vc.url = self.appinfo["url"] as? String ?? ""
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
            
            }
            self.viewController?.view.removeFromSuperview()
            self.removeLaunchScreenView()
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
                self.viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                self.window?.addSubview((self.viewController?.view)!)
                self.removeLaunchScreenView()
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

