//
//  AnimeCell.swift
//  capstone
//
//  Created by Vanessa Tang on 11/11/23.
//

import UIKit

class AnimeCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
