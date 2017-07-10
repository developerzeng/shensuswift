//
//  SliderSSNewsViewController.swift
//  ShenSu
//
//  Created by shensu on 17/6/20.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SliderSSNewsViewController: BaseViewController {
    var itemControlView: WJItemsControlView!
    let newsArray: Array<String> = ["双色球","大乐透","刮刮乐","时时彩","其他"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title: "彩票资讯")
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 44, w: self.view.width, h: self.view.height - 44))
        scroll.delegate = self
        scroll.isPagingEnabled = true
        scroll.contentSize = CGSize(width: self.view.width * CGFloat(newsArray.count), height: 44)
        newsArray.enumerated().forEach { (index,title) in
            let vc = SSNewsViewController()
            switch index {
            case 0:
              vc.titleName = "0"
            case 1:
               vc.titleName = "2"
            case 2:
               vc.titleName = "3"
            case 3:
                vc.titleName = "4"
            default:
                vc.titleName = "5"
            }
           
            vc.view.frame = CGRect(x: self.view.width * CGFloat(index), y: 0, w: self.view.width, h: self.view.height - 44)
            vc.didSelectedRowBlock = {model in
                let vc = SSNewsDetaViewController()
                vc.newDeatModel = model
                _ = self.navigationController?.pushViewController(vc, animated: true)
            
            }
            scroll.addSubview(vc.view)
        }
        self.view.addSubview(scroll)
        
        let config = WJItemsConfig()
        config.itemWidth = Float(CGFloat(Int(self.view.width) / 4))
        itemControlView = WJItemsControlView(frame: CGRect(x: 0, y: 0, w: self.view.width, h: 44))
        itemControlView.tapAnimation = true
        itemControlView.config = config
        itemControlView.titleArray = newsArray
        itemControlView.tapItemWithIndex = { (index,animation) in
          scroll.scrollRectToVisible(CGRect(x: (scroll.width) * CGFloat(index) , y: 0, w: self.view.width, h: (scroll.height)), animated: true)
        }
        self.view.addSubview(itemControlView)
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
extension SliderSSNewsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let index = offset / (scrollView.frame.width)
        itemControlView.move(toIndex: Float(index))
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let index = offset / (scrollView.frame.width)
        itemControlView.endMove(toIndex: Float(index))
    }

}
