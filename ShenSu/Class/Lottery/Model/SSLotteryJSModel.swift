//
//  SSLotteryJSModel.swift
//  ShenSu
//
//  Created by shensu on 17/5/31.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
class SSLotteryJSModel: NSObject, Mappable {
	var opendate: String = ""
	var issueno: String = ""
	var number: String = ""
	var refernumber: String = ""
	var saleamount: String = "0"
	var totalmoney: String = "0"
	var caipiaoid: String = ""
	var lotteryName: String {

		return getLotteryData(caipiaoid: caipiaoid)

	}
	private func getLotteryData(caipiaoid: String) -> String {
		let path = Bundle.main.path(forResource: "CaipiaoType", ofType: "geojson")
		let dic = NSDictionary(contentsOfFile: path!)
		let array = dic?["data"] as? Array<Any>
		var lottername = ""
		array?.enumerated().forEach({ (index, data) in
			let model = SSHomeSSLotteryModel()
			_ = self.JsonMapToObject(JSON: data, toObject: model)
			if model.caipiaoid == caipiaoid {
				lottername = model.name
			}
		})
		return lottername
	}

	var prize: Array<JSListModel>?
	required init?(map: Map) {

	}
	override init() {

	}
	func mapping(map: Map) {
		opendate <- map["opendate"]
		issueno <- map["issueno"]
		number <- map["number"]
		refernumber <- map["refernumber"]
		saleamount <- map["saleamount"]
		totalmoney <- map["totalmoney"]
		prize <- map["prize"]
	}
}
class JSListModel: NSObject, Mappable {
	var prizename: String = ""
	var require: String = ""
	var num: String = ""
	var singlebonus: String = ""
	var isFirst: Bool = false
	required init?(map: Map) {

	}
	override init() {

	}
	func mapping(map: Map) {
		prizename <- map["prizename"]
		require <- map["require"]
		num <- map["num"]
		singlebonus <- map["singlebonus"]

	}
}
//{
//    "total": "773",
//    "start": "0",
//    "num": "10",
//    "caipiaoid": "13",
//    "list": [
//    {
//    "opendate": "2017-05-29",
//    "issueno": "2017061",
//    "number": "11 12 15 17 23 28 30",
//    "refernumber": "08",
//    "saleamount": "5862318",
//    "totalmoney": "1435658",
//    "prize": [
//    {
//    "prizename": "一等奖",
//    "require": "中7+0",
//    "num": "0",
//    "singlebonus": "0"
//    },
//    {
//    "prizename": "二等奖",
//    "require": "中6+1",
//    "num": "3",
//    "singlebonus": "68364"
//    },
//    {
//    "prizename": "三等奖",
//    "require": "中6+0",
//    "num": "128",
//    "singlebonus": "3204"
//    },
//    {
//    "prizename": "四等奖",
//    "require": "中5+1",
//    "num": "478",
//    "singlebonus": "200"
//    },
//    {
//    "prizename": "五等奖",
//    "require": "中5+0",
//    "num": "5399",
//    "singlebonus": "50"
//    },
//    {
//    "prizename": "六等奖",
//    "require": "中4+1",
//    "num": "10879",
//    "singlebonus": "10"
//    },
//    {
//    "prizename": "七等奖",
//    "require": "中4+0",
//    "num": "69451",
//    "singlebonus": "5"
//    },
//    {
//    "prizename": "特别奖",
//    "require": "按官方活动规定",
//    "num": "0",
//    "singlebonus": "0"
//    }
//    ]
//}
