//
//  BookTableViewCell.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    static let nibName = "BookTableViewCell"

    @IBOutlet weak var lblBookName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(book: Book) {
        lblBookName.text = book.nombre
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
