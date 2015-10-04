//
//  EventTableViewCell.swift
//  ClubHub
//
//  Created by Kenny Law on 10/3/15.
//  Copyright © 2015 Kenny Law. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
