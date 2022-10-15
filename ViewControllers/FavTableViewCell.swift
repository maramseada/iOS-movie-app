//
//  FavTableViewCell.swift
//  project
//
//  Created by Maram Waleed on 07/08/2021.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var imagePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
