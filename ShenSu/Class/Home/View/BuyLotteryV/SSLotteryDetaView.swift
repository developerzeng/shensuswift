//
//  SSLotteryDetaView.swift
//  ShenSu
//
//  Created by shensu on 17/6/15.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import EasyPeasy
class SSLotteryDetaView: UIControl {
    func angle(angle: Double)->CGFloat{
     return CGFloat(M_PI * angle / 180)
    }
    var removeFromeSuperViewBlock:(()->())?
    var selectRowBlock:((IndexPath)->())?
    var tableViewBackView = UIView()
    var tableView:UITableView!
    var titleArray:Array<String>{
     return ["选号记录","规则说明","开奖记录"]
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x00000, alpha: 0.3)
        tableViewBackView.backgroundColor = UIColor.white
        self.addSubview(tableViewBackView)
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableViewBackView.addSubview(tableView)
      
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
        tableView <- [
        Edges(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
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
        bezierPath.addLine(to: point5)
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
extension SSLotteryDetaView: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.selectRowBlock?(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(140/3)
    }

}
