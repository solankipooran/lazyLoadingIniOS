//
//  UserTableViewCell.swift
//  paginationLazyLoading
//
//  Created by POORAN SUTHAR on 23/07/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var namlbl: UILabel!
    @IBOutlet weak var srnumber: UILabel!
    @IBOutlet weak var genderlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
