//
//  ObjectNet.swift
//  ShenSu
//
//  Created by shensu on 17/5/27.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import Alamofire
public class ObjectNet: NSObject {
	public static let `default` = ObjectNet()
	public func requestWithUrl(url: String, completionHandler: @escaping CompletionHandler) {
		NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .get, parameters: nil, completionHandler: completionHandler)
	}
    
    public func requesMethodtWithUrl(url: String, parameters: [String : Any]?,completionHandler: @escaping CompletionHandler) {
       NetWorkManager.default.rawRequestWithUrl(URLString: url, method: .post, parameters: parameters, completionHandler: completionHandler)
    }
    
}
