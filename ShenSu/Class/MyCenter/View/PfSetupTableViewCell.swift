//
//  PfSetupTableViewCell.swift
//  ShenSu
//
//  Created by shensu on 17/6/6.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit

class PfSetupTableViewCell: UITableViewCell {
	var setupSwitchBlock: ((UISwitch) -> ())?
	@IBOutlet weak var setupswitch: UISwitch!
	@IBOutlet weak var titleLable: UILabel!
	@IBOutlet weak var setupimageView: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func setModel(model: SetupModel) {
		setupimageView.image = UIImage(named: model.imageName)
		titleLable.text = model.title
		setupswitch.setOn(model.isswitch, animated: true)

	}

	@IBAction func switchClick(_ sender: Any) {
		let senderswitch = sender as? UISwitch
		self.setupSwitchBlock?(senderswitch!)
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
