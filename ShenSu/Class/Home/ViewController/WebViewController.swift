//
//  WebViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/8.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import WebKit
import EasyPeasy
class WebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {
	var wkweb: WKWebView!
	var url: String = ""
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavTitle(title: "详情")
		wkweb = WKWebView(frame: CGRect.zero)
		wkweb.uiDelegate = self
		wkweb.navigationDelegate = self
		wkweb.load(URLRequest(url: URL.init(string: url)!))
		self.view.addSubview(wkweb)
        wkweb <- [
        
        Edges(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        ]
		// Do any additional setup after loading the view.
	}
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		self.showLoadingView()
	}
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		self.hideLoadingView()
	}
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		self.hideLoadingView()
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
