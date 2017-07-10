//
//  SSNaddZJTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/7/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class SSNaddZJTableViewCell: UITableViewCell {

    @IBAction func buttonClick(_ sender: Any) {
    }
    @IBOutlet weak var lotteryLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        priceLable.textColor = UIColor.orangeRedColor()
    }
    func setModel(model:NaddZJMode){
    priceLable.text = model.money
    lotteryLable.text = model.w_lot_name
     let attr = try? NSMutableAttributedString.init(data: (model.w_title_template.data(using: .unicode))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
    titleLable.attributedText = attr
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
