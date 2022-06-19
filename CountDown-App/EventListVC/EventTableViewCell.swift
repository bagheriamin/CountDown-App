//
//  EventTableViewCell.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    //Identifier for cell
    static let identifier = String(describing: EventTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emoji: UILabel!
    
    func setUp(event: Event) {
        nameLabel.text = event.name
    }
    
}
