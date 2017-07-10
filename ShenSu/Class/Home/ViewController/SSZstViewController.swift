//
//  SSZstViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import WebKit
import EasyPeasy
class SSZstViewController: BaseViewController,WKUIDelegate,WKNavigationDelegate {
    var wkView : WKWebView?
    var zstCon: SSZstControl!
    var url: String! {
        didSet{
         _ =  wkView?.load(URLRequest(url: URL(string:url)!))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wkView = WKWebView(frame: self.view.bounds)
        wkView?.uiDelegate = self
        wkView?.navigationDelegate = self
        self.view.addSubview(wkView!)
        self.setNavRightButton(image: UIImage(named:"more")!)
        zstCon = SSZstControl(frame: self.view.bounds)
        url = (zstCon.dataArray.first?.url)!
        self.setNavTitle(title: (zstCon.dataArray.first?.title)!)
        zstCon.szstSelectedItem = { model in
        self.url = model.url
         self.setNavTitle(title: (model.title)!)
        }
        self.rightButtonClicked = {[weak self] btn in
            if self?.zstCon.superview != nil {
            self?.view.addSubview((self?.zstCon)!)
            }else{
            self?.view.addSubview((self?.zstCon)!)
            }
        }
        wkView! <- [
        Edges(UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0))
        ]
        
        // Do any azstBtndditional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
