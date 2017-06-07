//
//  HomeLotteryModel.swift
//  ShenSu
//
//  Created by shensu on 17/5/17.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class HomeLotteryModel: NSObject, Mappable {
	var name: String!
	var url: String!
	var rule: Array<ruleModel>!
    var caipiaoid: String!
    var  subTitle: String = ""
	override init() {

	}

	required init?(map: Map) {

	}

	func mapping(map: Map) {
		name <- map["name"]
		url <- map["url"]
		rule <- map["rule"]
        caipiaoid <- map["caipiaoid"]
        subTitle <- map["subTitle"]
	}

}
class ruleModel: NSObject, Mappable {
	var Cmin: String!
	var Nmin: String!
	var Nmax: String!
	override init() {

	}

	required init?(map: Map) {

	}

	func mapping(map: Map) {
		Cmin <- map["Cmin"]
		Nmin <- map["Nmin"]
		Nmax <- map["Nmax"]
	}
}
