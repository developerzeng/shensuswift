//
//  ChooseView.swift
//  ShenSu
//
//  Created by shensu on 17/5/16.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import ObjectMapper
class ChooseView: UIView {
	// 初始化时将xib中的view添加进来
	var dataArray = Array<ChooseModel>()
	var contentView: UIView!
	var timer: Timer!
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView = loadViewFromNib()
		addSubview(contentView)
		imageView.image = UIImage(named: "guangao")
		let json = [[
			"tip_content": "恭喜【李**】投注广西快3中奖200元"
			], [
			"tip_content": "恭喜【中**】投注广西快3中奖40元"
			], [
			"tip_content": "恭喜【A**】投注广西快3中奖40元"
			], [
			"tip_content": "恭喜【明**】投注山东11x5中奖145元"
			], [
			"tip_content": "恭喜【飞**】投注山东11x5中奖110元"
			], [
			"tip_content": "恭喜【徐**】投注山东11x5中奖29元"
			], [
			"tip_content": "恭喜【w**】投注山东11x5中奖22元"
			], [
			"tip_content": "恭喜【S**】投注广东11x5中奖110元"
			], [
			"tip_content": "恭喜【a**】投注广东11x5中奖22元"
			], [
			"tip_content": "恭喜【庐**】投注广东11x5中奖9元"
			], [
			"tip_content": "恭喜【可**】投注江西11x5中奖435元"
			], [
			"tip_content": "恭喜【寜**】投注江西11x5中奖220元"
			], [
			"tip_content": "恭喜【z**】投注江西11x5中奖66元"
			], [
			"tip_content": "恭喜【叶**】投注江西11x5中奖22元"
			], [
			"tip_content": "恭喜【F**】投注江西11x5中奖22元"
			], [
			"tip_content": "恭喜【R**】投注广西快3中奖9元"
			], [
			"tip_content": "恭喜【头**】投注山东11x5中奖2,420元"
			], [
			"tip_content": "恭喜【明**】投注山东11x5中奖435元"
			], [
			"tip_content": "恭喜【张**】投注山东11x5中奖44元"
			], [
			"tip_content": "恭喜【可**】投注山东11x5中奖29元"
		]]
		json.enumerated().forEach { (index, data) in
			let model = ChooseModel()
			_ = self.JsonMapToObject(JSON: data, toObject: model)
			dataArray.append(model)
		}
		var count = 0
		self.titleLable.text = self.dataArray[0].tip_content
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
                UIView.animate(withDuration: 0.25, animations: {
                    count += 1
                    if count == self.dataArray.count {
                        count = 0
                    }
                    self.titleLable.text = self.dataArray[count].tip_content
                    var center = self.center
                    center.y = -50
                    self.titleLable.center.y = center.y
                }, completion: { (finish) in
                    var center = self.center
                    center.y += 50
                    self.titleLable.center.y = center.y
                    UIView.animate(withDuration: 0.5, animations: {
                        self.titleLable.center.y = self.contentView.center.y
                    })
                    
                })
            })
        } else {
            // Fallback on earlier versions
        }
		RunLoop.current.add(timer, forMode: .commonModes)
		self.titleLable.textColor = UIColor.orangeRedColor()

	}

	override func layoutSubviews() {
		contentView.frame = CGRect(x: 20, y: 0, w: frame.width - 40, h: frame.height)
		contentView.layer.cornerRadius = frame.height / 2
		contentView.layer.masksToBounds = true

	}
	// 初始化时将xib中的view添加进来
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		contentView = loadViewFromNib()
		addSubview(contentView)

	}
	// 加载xib
	func loadViewFromNib() -> UIView {
		let className = type(of: self)
		let bundle = Bundle(for: className)
		let name = NSStringFromClass(className).components(separatedBy: ".").last
		let nib = UINib(nibName: name!, bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
		return view
	}

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLable: UILabel!
	/*
	 // Only override draw() if you perform custom drawing.
	 // An empty implementation adversely affects performance during animation.
	 override func draw(_ rect: CGRect) {
	 // Drawing code
	 }
	 */

}
class ChooseModel: NSObject, Mappable {
	var tip_content: String = ""

	required init?(map: Map) {

	}
	override init() {

	}
	func mapping(map: Map) {
		tip_content <- map["tip_content"]

	}

}
