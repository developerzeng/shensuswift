//
//  NewsTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/6/5.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
enum NewsCellType:UInt {
    case cellNotIcon
    case cellWithIcon
}
class NewsTableViewCell: UITableViewCell {
 var celltyep:NewsCellType = .cellNotIcon
	@IBOutlet weak var newsSubtitle: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var newsTitle: UILabel!
	@IBOutlet weak var newImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
        if celltyep == .cellNotIcon {
            newImage.removeFromSuperview()
            self.contentView.layoutIfNeeded()
        }
	}
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
	func setModel(model: NewsModel) {
	
		newsTitle.text = model.title
		newsSubtitle.text = model.content
		timeLabel.text = "\(model.author) \(model.timeForShow)"
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
