//
//  lotteryListModel.swift
//  ShenSu
//
//  Created by shensu on 17/5/25.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class LotteryListModel: NSObject, NSCoding {
	var lotteryType: String = ""
	var lotteryNumber: String = ""
	var lotteryCount: String = ""
	var lotteryExpect: String = ""
	var addtime: String = ""
	func encode(with aCoder: NSCoder) {
		aCoder.encode(lotteryType, forKey: "lotteryType")
		aCoder.encode(lotteryNumber, forKey: "lotteryNumber")
		aCoder.encode(lotteryCount, forKey: "lotteryCount")
		aCoder.encode(lotteryExpect, forKey: "lotteryExpect")
		aCoder.encode(addtime, forKey: "addtime")
	}
	required init?(coder aDecoder: NSCoder) {
		lotteryType = aDecoder.decodeObject(forKey: "lotteryType") as? String ?? ""
		lotteryNumber = aDecoder.decodeObject(forKey: "lotteryNumber") as? String ?? ""
		lotteryCount = aDecoder.decodeObject(forKey: "lotteryCount") as? String ?? ""
		lotteryExpect = aDecoder.decodeObject(forKey: "lotteryExpect") as? String ?? ""
		addtime = aDecoder.decodeObject(forKey: "addtime") as? String ?? ""
	}
	override init() {
		super.init()
	}
}
