//
//  GenreCell.swift
//  capstone
//
//  Created by Vanessa Tang on 11/16/23.
//

import UIKit

class GenreCell: UITableViewCell {

    @IBOutlet weak var genre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
