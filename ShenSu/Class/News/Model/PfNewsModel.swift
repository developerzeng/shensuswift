//
//  PfNewsModel.swift
//  ShenSu
//
//  Created by shensu on 17/6/5.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
class PfNewsModel: NSObject, Mappable {
	var author: String = "彩票公告"
	var clickCount: String = ""
	var clubName: String = ""
	var content: String = ""
	var createTime: String = ""
	var goodFlag: String = ""
	var hotFlag: String = ""
	var icon: String = ""
	var id: String = ""
	var isLike: String = ""
	var level: String = ""
	var modelType: String = ""
	var memberId: String = ""
	var oid: Int = 0
	var replyCount: String = ""
	var scoreLevel: String = ""
	var style: String = ""
	var timeForShow: String = ""
	var title: String = ""
	var topFlag: String = ""

	required init?(map: Map) {

	}
	override init() {

	}
	func mapping(map: Map) {
		author <- map["author"]
		clickCount <- map["clickCount"]
		clubName <- map["clubName"]
		content <- map["content"]
		createTime <- map["addtime"]
		goodFlag <- map["goodFlag"]
		hotFlag <- map["hotFlag"]
		icon <- map["icon"]
		id <- map["id"]
		isLike <- map["isLike"]
		level <- map["level"]
		modelType <- map["modelType"]
		memberId <- map["memberId"]
		oid <- map["oid"]
		replyCount <- map["replyCount"]
		scoreLevel <- map["scoreLevel"]
		style <- map["style"]
		timeForShow <- map["view"]
		title <- map["title"]
		topFlag <- map["topFlag"]

	}
}
//{
//    "author": "公告消息",
//    "clickCount": 108,
//    "clubName": "讲堂",
//    "content": "在竞彩几种玩法当中，总进球数的难度仅次于比分，之所以比较难，",
//    "createTime": 1496193352000,
//    "goodFlag": 0,
//    "hotFlag": 0,
//    "icon": "https://rm.aicai.com/upload/memberphoto/692/tn_1478585828989_160_160.jpg",
//    "id": 12447,
//    "isLike": false,
//    "level": 5,
//    "memberId": 54831692,
//    "modelType": 2,
//    "msgType": 10,
//    "oid": 12447,
//    "replyCount": 0,
//    "scoreLevel": 0,
//    "style": 0,
//    "timeForShow": "05-31 09:15",
//    "title": "买竞彩投资回报高 如何玩转总进球",
//    "topFlag": 0
//}
