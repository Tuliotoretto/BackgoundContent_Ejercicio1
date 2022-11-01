//
//  CharacterTableViewCell.swift
//  BackgoundContent
//
//  Created by Julian Garcia  on 31/10/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var characterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
