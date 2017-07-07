//
//  NaddTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/7/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class NaddTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitleLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setModel(model: NaddModel){
    titleLable.text = model.article_title
    subTitleLable.text = model.crt_time?.toFormatDateString(format: "YYYY-MM-dd HH:mm")
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
