//
//  HomecellHeadCollectionReusableView.swift
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
class HomecellHeadCollectionReusableView: UICollectionReusableView {
    var headImage:UIImageView!
    var headTitl:UILabel!
    override init(frame:CGRect) {
        super.init(frame: frame)
        headImage = UIImageView()
        self.addSubview(headImage)
        headTitl = UILabel()
        headTitl.font = UIFont.systemFont(ofSize: 14)
        headTitl.textColor = UIColor.lightGray
        self.addSubview(headTitl)
        
        headImage <- [
        Left(15).to(self, .left),
        CenterY(0).to(self),
        Size(CGSize(width: 20, height: 20))
        ]
        headTitl <- [
            Left(10).to(headImage, .right),
            CenterY(0).to(self),
            Height(20)
        ]
        
    }
    func setModel(model: HomecellModel){
    headImage.image = UIImage(named: model.imaegName)
    headTitl.text = model.title
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
