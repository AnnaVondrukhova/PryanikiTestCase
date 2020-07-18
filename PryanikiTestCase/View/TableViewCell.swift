//
//  TableViewCell.swift
//  PryanikiTestCase
//
//  Created by Anya on 16.07.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with name: String) {
        nameLabel.text = name
    }

}
