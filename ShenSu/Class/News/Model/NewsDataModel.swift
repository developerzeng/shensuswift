//
//  NewsDataModel.swift
//  ShenSu
//
//  Created by shensu on 17/6/5.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class NewsDataModel: NSObject, Mappable {
	var memberInfo: MemberInfo!
	var expertReplayDetail: ExpertReplayDetail!
	override init() {

	}
	required init?(map: Map) {

	}
	func mapping(map: Map) {
		memberInfo <- map["memberInfo"]
		expertReplayDetail <- map["expertReplayDetail"]

	}
}
class MemberInfo: NSObject, Mappable {
	var aicaiMemberId: String = ""
	var icon: String = ""
	var jcobMemberId: String = ""
	var nickName: String = ""
	override init() {

	}
	required init?(map: Map) {

	}
	func mapping(map: Map) {
		aicaiMemberId <- map["aicaiMemberId"]
		icon <- map["icon"]
		jcobMemberId <- map["jcobMemberId"]
		nickName <- map["nickName"]
	}
}
class ExpertReplayDetail: NSObject, Mappable {
	var aicaiId: String = ""
	var author: String = ""
	var clickCount: Int!
	var clubName: String = ""
	var content: String = ""
	var createAccount: String = ""
	var createTime: String = ""
	var dislikePercent: String = ""
	var id: String = ""
	var isElite: String = ""
	var isHot: String = ""
	var isTop: String = ""
	var likePercent: String = ""
	var title: String = ""
	override init() {

	}
	required init?(map: Map) {

	}
	func mapping(map: Map) {
		aicaiId <- map["aicaiId"]
		author <- map["author"]
		clickCount <- map["clickCount"]
		clubName <- map["clubName"]
		content <- map["content"]
		createAccount <- map["createAccount"]
		createTime <- map["createTime"]
		id <- map["id"]
		isElite <- map["isElite"]
		isHot <- map["isHot"]
		isTop <- map["isTop"]
		likePercent <- map["likePercent"]
		title <- map["title"]

	}
}
