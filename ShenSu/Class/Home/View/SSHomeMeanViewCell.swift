//
//  HomeMeanView.swift
//  ShenSu
//
//  Created by shensu on 17/6/21.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SSHomeMeanViewCell: UICollectionViewCell {
    var cpShop : UIButton!
    var smBtn : UIButton!
    var zxBtn : UIButton!
    var zstBtn : UIButton!
    var homeMeanBlock:((Int)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        cpShop = UIButton(type: .custom)
        cpShop.setTitle("彩票店", for: .normal)
        cpShop.setImage(UIImage.init(named: "店"), for: .normal)
        cpShop.tag = 1001
        cpShop.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cpShop.setTitleColor(UIColor.gray, for: .normal)
        cpShop.addTarget(self, action: #selector(cpShopClick), for: .touchUpInside)
        self.contentView.addSubview(cpShop)
        smBtn = UIButton(type: .custom)
        smBtn.setTitle("彩票验证", for: .normal)
        smBtn.tag = 1002
        smBtn.setImage(UIImage.init(named: "二维码"), for: .normal)
        smBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        smBtn.setTitleColor(UIColor.gray, for: .normal)
        smBtn.addTarget(self, action: #selector(cpShopClick), for: .touchUpInside)
        self.contentView.addSubview(smBtn)
        zxBtn = UIButton(type: .custom)
        zxBtn.setTitle("资讯", for: .normal)
        zxBtn.tag = 1003
        zxBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        zxBtn.setImage(UIImage.init(named: "资讯"), for: .normal)
        zxBtn.setTitleColor(UIColor.gray, for: .normal)
        zxBtn.addTarget(self, action: #selector(cpShopClick), for: .touchUpInside)
        self.contentView.addSubview(zxBtn)
        
        
        
        zstBtn = UIButton(type: .custom)
        zstBtn.setTitle("走势图", for: .normal)
        zstBtn.tag = 1004
        zstBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        zstBtn.setImage(UIImage.init(named: "走势图"), for: .normal)
        zstBtn.setTitleColor(UIColor.gray, for: .normal)
        zstBtn.addTarget(self, action: #selector(cpShopClick), for: .touchUpInside)
        self.contentView.addSubview(zstBtn)
        
        addConstraint()
        cpShop.imageButtonInsetsType(type: .ImageButtonTop, imagewithTitleSpace: 10)
        zxBtn.imageButtonInsetsType(type: .ImageButtonTop, imagewithTitleSpace: 10)
        smBtn.imageButtonInsetsType(type: .ImageButtonTop, imagewithTitleSpace: 10)
        zstBtn.imageButtonInsetsType(type: .ImageButtonTop, imagewithTitleSpace: 10)
    }
    func addConstraint() {
        cpShop.translatesAutoresizingMaskIntoConstraints = false
        smBtn.translatesAutoresizingMaskIntoConstraints = false
        zxBtn.translatesAutoresizingMaskIntoConstraints = false
        zstBtn.translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view1(==view2)][view2(==view3)][view3(==view1)][view4(==view3)]|", options: [], metrics: nil, views: ["view1":cpShop,"view2":smBtn,"view3":zxBtn , "view4":zstBtn]) + NSLayoutConstraint.constraints(withVisualFormat: "V:|[view1(==view2)]|", options: [], metrics: nil, views: ["view1":cpShop,"view2":self]) + NSLayoutConstraint.constraints(withVisualFormat: "V:|[view2(==view3)]|", options: [], metrics: nil, views: ["view2":smBtn,"view3":self]) + NSLayoutConstraint.constraints(withVisualFormat: "V:|[view3(==view1)]|", options: [], metrics: nil, views: ["view1":self,"view3":zxBtn]) + NSLayoutConstraint.constraints(withVisualFormat: "V:|[view4(==view1)]|", options: [], metrics: nil, views: ["view1":self,"view4":zstBtn])
            NSLayoutConstraint.activate(constraint)
        
    }
    func cpShopClick(sender: UIButton){
    self.homeMeanBlock?(sender.tag)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
