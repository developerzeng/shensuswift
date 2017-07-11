//
//  AppUserData.swift
//  ShenSu
//
//  Created by shensu on 17/5/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class AppUserData: NSObject {
	public static let `default` = AppUserData()
	var userDefaults: UserDefaults {
		return UserDefaults.standard
	}
	var userAccount: String? {
		get {
			return userDefaults.value(forKey: "userAccount") as? String
		}
		set {
			userDefaults.set(newValue, forKey: "userAccount")
			userDefaults.synchronize()
		}

	}
	var password: String? {
		get {
			return userDefaults.value(forKey: "password") as? String
		}
		set {
			userDefaults.set(newValue, forKey: "password")
			userDefaults.synchronize()
		}

	}
	var nickName: String? {
		get {
			return userDefaults.value(forKey: "nickName") as? String
		}
		set {
			userDefaults.set(newValue, forKey: "nickName")
			userDefaults.synchronize()
		}

	}
	var isLogin: Bool {
		get {
			return userDefaults.value(forKey: "isLogin") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "isLogin")
			userDefaults.synchronize()
		}
	}
	var ssqpush: Bool {
		get {
			return userDefaults.value(forKey: "ssq") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "ssq")
			userDefaults.synchronize()
		}
	}
	var dltpush: Bool {
		get {
			return userDefaults.value(forKey: "dlt") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "dlt")
			userDefaults.synchronize()
		}
	}
	var d3push: Bool {
		get {
			return userDefaults.value(forKey: "d3") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "d3")
			userDefaults.synchronize()
		}
	}
	var yyypush: Bool {
		get {
			return userDefaults.value(forKey: "yyy") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "yyy")
			userDefaults.synchronize()
		}
	}
	var zjpush: Bool {
		get {
			return userDefaults.value(forKey: "zj") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "zj")
			userDefaults.synchronize()
		}
	}
	var kjpush: Bool {
		get {
			return userDefaults.value(forKey: "kj") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "kj")
			userDefaults.synchronize()
		}
	}
	var gcpush: Bool {
		get {
			return userDefaults.value(forKey: "gc") as? Bool ?? false
		}
		set {
			userDefaults.set(newValue, forKey: "gc")
			userDefaults.synchronize()
		}
	}
    /// 彩票种类
    var lotteryClass: Array<Dictionary<String,String>>? {
        get {
            let path = NSHomeDirectory()
            let file = "\(path)/Library/Caches/lotteryClass.plist"
            if (NSArray(contentsOfFile: file) != nil){
            return NSArray(contentsOfFile: file) as? Array<Dictionary<String,String>>
            }
            return nil
        }
        set {
         let path = NSHomeDirectory()
         let file = "\(path)/Library/Caches/lotteryClass.plist"
            let new:NSArray? = newValue as NSArray?
            if  new?.write(toFile: file, atomically: true) == true {
            debugPrint("写入成功")
            }else {
            debugPrint("写入失败")
            }
            
        }
    }
	/// 下注存储数据
	var saveModel: Array<PfLotteryListModel>? {
		get {
			let path = NSHomeDirectory()
			let file = "\(path)/Library/Caches/lotteryMoldes"
			if NSKeyedUnarchiver.unarchiveObject(withFile: file) != nil {
				return NSKeyedUnarchiver.unarchiveObject(withFile: file) as? Array<PfLotteryListModel>
			}
			return nil
		}
		set {
			let path = NSHomeDirectory()
			let file = "\(path)/Library/Caches/lotteryMoldes"
			var oldArray = Array<PfLotteryListModel>()
			if NSKeyedUnarchiver.unarchiveObject(withFile: file) != nil {
				oldArray = NSKeyedUnarchiver.unarchiveObject(withFile: file) as! Array<PfLotteryListModel>
			}
			if oldArray.count == 0 {
				NSKeyedArchiver.archiveRootObject(newValue!, toFile: file)
			} else {
				oldArray += newValue!
				NSKeyedArchiver.archiveRootObject(oldArray, toFile: file)
			}
		}
	}
	/// 首页收藏数据
	var homesaveModel: Array<PfLotteryListModel>? {
		get {
			let path = NSHomeDirectory()
			let file = "\(path)/Library/Caches/homelotteryMoldes"
			if NSKeyedUnarchiver.unarchiveObject(withFile: file) != nil {
				return NSKeyedUnarchiver.unarchiveObject(withFile: file) as? Array<PfLotteryListModel>
			}
			return nil
		}
		set {
			let path = NSHomeDirectory()
			let file = "\(path)/Library/Caches/homelotteryMoldes"
			var oldArray = Array<PfLotteryListModel>()
			if NSKeyedUnarchiver.unarchiveObject(withFile: file) != nil {
				oldArray = NSKeyedUnarchiver.unarchiveObject(withFile: file) as! Array<PfLotteryListModel>
			}
			if oldArray.count == 0 {
				NSKeyedArchiver.archiveRootObject(newValue!, toFile: file)
			} else {
				oldArray += newValue!
				NSKeyedArchiver.archiveRootObject(oldArray, toFile: file)
			}
		}
	}

}
