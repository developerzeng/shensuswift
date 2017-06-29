//
//  ZstControl.swift
//  ShenSu
//
//  Created by shensu on 17/6/26.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
struct ZstModel {
    var title:String!
    var url:String!
}
class ZstControl: UIControl {
    var collectionView: UICollectionView!
    var szstSelectedItem:((ZstModel)->())?
    var dataArray:Array<ZstModel>{
    let model = ZstModel(title: "超级大乐透", url: "http://m.500.com/datachart/dlt/")
    let model1 = ZstModel(title: "双色球", url: "http://m.500.com/datachart/ssq/")
    let model2 = ZstModel(title: "排列三", url: "http://m.500.com/datachart/pls/")
    let model3 = ZstModel(title: "七星彩", url: "http://m.500.com/lottery/qxc/chart/chart.html")
    let model4 = ZstModel(title: "七乐彩", url: "http://m.500.com/datachart/qlc/jb.html")
    let model5 = ZstModel(title: "福彩3D", url: "http://m.500.com/datachart/3d/")
    let model6 = ZstModel(title: "排列五", url: "http://m.500.com/lottery/plw/chart/chart.html")
    let model7 = ZstModel(title: "足彩", url: "http://m.500.com/datachart/sfc/zfb/2.html")
    let model8 = ZstModel(title: "江西11选5", url: "http://m.500.com/datachart/dlc/jb.html")
    let model9 = ZstModel(title: "江苏11选5", url: "http://m.500.com/datachart/jssyxw/jb.html")
    let model10 = ZstModel(title: "幸运赛车", url: "http://m.500.com/datachart/xysc/q1.html")
    let model11 = ZstModel(title: "重庆时时彩", url: "http://m.500.com/datachart/ssc/zx/ww.html")
    return [model,model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11]
    }
    override init(frame:CGRect){
    super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.3)
      let layout = UICollectionViewFlowLayout()
      layout.minimumLineSpacing = 10
      layout.minimumInteritemSpacing = 10
      layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      layout.itemSize = CGSize(width: (self.frame.width - 50) / 3, height: 30)
      collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.backgroundColor = UIColor.white
      collectionView.layer.cornerRadius = 4
      collectionView.register(ZstCollectionCell.self, forCellWithReuseIdentifier: "cell")
      self.addSubview(collectionView)
        
      collectionView <- [
      Left(0).to(self, .left),
      Right(0).to(self, .right),
      Top(0).to(self, .top),
      Height(160)
      ]
    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
   
 

}
extension ZstControl : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ZstCollectionCell
        cell?.title.text = dataArray[indexPath.row].title
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.szstSelectedItem?(dataArray[indexPath.row])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.removeFromSuperview()
        }
    }
}
class ZstCollectionCell: UICollectionViewCell {
    var title:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12)
        title.textAlignment = .center
        title.layer.cornerRadius = 4
        title.layer.borderWidth = 0.5
        title.layer.borderColor = UIColor.lightGray.cgColor
        title.textColor = UIColor.lightGray
        title.frame = self.contentView.frame
        self.contentView.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

