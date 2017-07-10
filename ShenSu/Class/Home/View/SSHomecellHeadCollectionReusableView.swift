//
//  SSHomecellHeadCollectionReusableView.swift
//  ShenSu
//
//  Created by shensu on 17/6/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
struct HomecellModel {
    var imaegName:String!
    var title:String!
}
class SSHomecellHeadCollectionReusableView: UICollectionReusableView {
    var headImage:UIImageView!
    var headTitl:UILabel!
    override init(frame:CGRect) {
        super.init(frame: frame)
//        headImage = UIImageView()
//        self.addSubview(headImage)
        headTitl = UILabel()
        headTitl.textColor = UIColor.orangeRedColor()
        headTitl.font = UIFont.systemFont(ofSize: 14)
        headTitl.backgroundColor = UIColor.white
        headTitl.textAlignment = .center
        self.addSubview(headTitl)
        
//        headImage <- [
//        Left(15).to(self, .left),
//        CenterY(0).to(self),
//        Size(CGSize(width: 20, height: 20))
//        ]
        headTitl <- [
           Edges(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        ]
        
    }
    func setModel(model: HomecellModel){
//    headImage.image = UIImage(named: model.imaegName)
    headTitl.text = "—————— \(model.title!) ——————"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
