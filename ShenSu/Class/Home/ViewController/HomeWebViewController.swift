//
//  HomeWebViewController.swift
//  ShenSu
//
//  Created by shensu on 17/7/4.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import WebKit
import EasyPeasy
class HomeWebViewController: BaseViewController  {
    var wkWebView: WKWebView!
    var url: String!
    var titleName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title: titleName)
        wkWebView = WKWebView(frame: CGRect.zero)
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
//        let customAllowedSet =  NSCharacterSet(charactersIn:"`#%^{}\"[]|\\<> ").inverted
//        let encode = url.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        wkWebView.load(URLRequest(url: URL(string:url)!))
    
        self.view.addSubview(wkWebView)
        wkWebView <- [
        Edges(UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0))
        ]
        // Do any additional setup after loading the view.
        
        
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
extension HomeWebViewController : WKUIDelegate,WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showLoadingView()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.hideLoadingView()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoadingView()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        return   //忽略这个错误。
            
            
            self.hideLoadingView()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request.url
        
        if request?.absoluteString.contains("openList")  == true {
            let alert = UIAlertController(title: "是否要在Safari打开连接", message: "本运用所以活动均与苹果公司无关", preferredStyle: .alert)
            let defa = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(request!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(request!)
                }
            })
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                
            })
            alert.addAction(defa)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        decisionHandler(.cancel)
        }
        decisionHandler(.allow)
        
        
    }

}
