//
//  SSBannarModel.swift
//  ShenSu
//
//  Created by shensu on 17/5/16.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class SSBannarModel: NSObject, Mappable {

	var bannarUrl: String = ""
	var openUrl: String = ""
	var bannarID: String = ""
	required init?(map: Map) {

	}
	override init() {

	}
	func mapping(map: Map) {
		bannarUrl <- map["ImgUrl"]
		openUrl <- map["AritleUrl"]

	}

}
