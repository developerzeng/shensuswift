//
//  LotteryDetaView.swift
//  ShenSu
//
//  Created by shensu on 17/6/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class LotteryDetaView: UIControl {
    func angle(angle: Double)->CGFloat{
     return CGFloat(M_PI * angle / 180)
    }
    var removeFromeSuperViewBlock:(()->())?
    var tableViewBackView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x00000, alpha: 0.3)
        tableViewBackView.backgroundColor = UIColor.white
        self.addSubview(tableViewBackView)
      
    }
    func animationtableViewBackView(){
        let rect = tableViewBackView.frame
        let size = CGSize(width: rect.width, height: 0)
        tableViewBackView.size = size
        
        UIView.animate(withDuration: 0.6, animations: {
            self.tableViewBackView.frame = rect
            self.createLayerWithView(view: self.tableViewBackView)
        }) { (finish) in
            
        }
        
    
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        animationtableViewBackView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromeSuperViewBlock?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tableViewBackView <- [
            Top(0).to(self),
            Right(10).to(self),
            Height(150),
            Width(self.frame.width/4 + 20)
        ]
       animationtableViewBackView()
    }
    func createLayerWithView(view : UIView){
        let viewWidth=view.frame.width;
        let viewHeight=view.frame.height;
        let point1 = CGPoint(x: 0, y: 10)
        let point2 = CGPoint(x:viewWidth-35,y:10);
        let point3 = CGPoint(x:viewWidth-25,y: 0);
        let point4 = CGPoint(x:viewWidth-15,y:10);
        let point5 = CGPoint(x:viewWidth,y:10);
        let point6 = CGPoint(x:viewWidth , y:viewHeight);
        let point7 = CGPoint(x:0, y:viewHeight);
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: point1)
        bezierPath.addLine(to: point2)
        bezierPath.addLine(to: point3)
        bezierPath.addLine(to: point4)
        bezierPath.addArc(withCenter: CGPoint(x:point5.x - 2,y:point5.y - 2), radius: 4.0, startAngle: CGFloat(M_PI), endAngle:  CGFloat(M_PI_2) * 3, clockwise: true)
//        bezierPath.addLine(to: point5)
        bezierPath.addLine(to: point6)
        bezierPath.addLine(to: point7)
        bezierPath.close()
        
        let layer = CAShapeLayer()
        layer.path = bezierPath.cgPath
        view.layer.mask = layer
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
