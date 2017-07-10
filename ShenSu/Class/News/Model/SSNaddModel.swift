//
//  SSNaddModel.swift
//  ShenSu
//
//  Created by shensu on 17/7/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class SSNaddModel: NSObject, Mappable {
    var article_detail_url:String!
    var article_id:String!
    var article_title:String!
    var crt_time:Date?
    var file_path:String!
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    func mapping(map: Map) {
        article_detail_url <- map["article_detail_url"]
        article_id <- map["article_id"]
        article_title <- map["article_title"]
        crt_time <- (map["crt_time"], TimeIntervalTransform())
        file_path <- map["file_path"]
        
    }
}
/*
 "money": "28万",
 "w_expert": "16137",
 "w_info_absolute_url": "http://mycp.iplay78.com/info/dcbfbc8fcdbb4ea8a34dc569a28ed62c.html",
 "w_info_url": "act/zjfd/2016120701/index.html",
 "w_lot_id": "301",
 "w_lot_name": "双色球",
 "w_title_template": "惊爆大奖！周二幸运用户“羽翼**”凭借单倍复式投注双色球豪揽1注二等奖、18注四等奖和45注五等奖，豪夺奖金<span class=\"red\">28万</span>！"
 
 */
class NaddZJMode: NSObject, Mappable {
    var money:String!
    var w_expert:String!
    var w_info_absolute_url:String!
    var w_info_url:String!
    var w_lot_id:String!
    var w_title_template:String!
    var w_lot_name:String!
    required init?(map: Map) {
        
    }
    override init() {
        
    }
    func mapping(map: Map) {
        money <- map["money"]
        w_expert <- map["w_expert"]
        w_info_absolute_url <- map["w_info_absolute_url"]
        w_info_url <- map["w_info_url"]
        w_lot_id <- map["w_lot_id"]
        w_title_template <- map["w_title_template"]
        w_lot_name <- map["w_lot_name"]
    }
}
