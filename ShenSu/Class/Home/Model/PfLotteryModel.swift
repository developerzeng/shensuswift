//
//  PfLotteryModel.swift
//  ShenSu
//
//  Created by shensu on 17/5/24.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class PfLotteryModel: NSObject, Mappable {
//{"expect":"2017059","opencode":"04,08,09,15,19,25+09","opentime":"2017-05-23 21:18:20","opentimestamp":1495545500}
	var expect: String = ""
	var opencode: String = ""
	var opentime: String = ""
	var opentimestamp: Date!
	required init?(map: Map) {

	}
	override init() {

	}
	func mapping(map: Map) {
		expect <- map["expect"]
		opencode <- map["opencode"]
		opentime <- map["opentime"]
		opentimestamp <- (map["opentimestamp"], TimeIntervalTransform())

	}
}
