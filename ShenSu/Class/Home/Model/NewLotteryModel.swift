//
//  NewLotteryModel.swift
//  ShenSu
//
//  Created by shensu on 17/7/4.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class NewLotteryModel: NSObject , Mappable {
    var is_title_highlight:String!
    var lot_code:String!
    var lot_name:String!
    var lot_pic:String!
    var lot_tag:String!
    var lot_title:String!
    var lot_url:String!
    required init?(map: Map) {
        
   

        
    }
    func mapping(map: Map) {
        is_title_highlight <- map["is_title_highlight"]
        lot_code <- map["lot_code"]
        lot_name <- map["lot_name"]
        lot_pic <- map["lot_pic"]
        lot_tag <- map["lot_tag"]
        lot_title <- map["lot_title"]
        lot_url <- map["lot_url"]
    }
    override init() {
        
    }
}
/*
 {
 is_title_highlight= "0";
 lot_code= "701";
 lot_name= "竞彩足球";
 lot_pic= "/lot/icon_jczq.png";
 lot_tag= "1001000000";
 lot_title= "倍投收益更高";
 lot_url= "http=//mycp.iplay78.com/a/APPH5/buy/jczq.html";
 }
 
 */
