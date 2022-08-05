//
//  ChaptersTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/5/22.
//

import UIKit

class ChaptersTableViewCell: UITableViewCell {
    func updateCellView() {
        self.backgroundColor = .red
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
