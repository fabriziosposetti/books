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

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblPriority: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(book: Book) {
        lblBookName.text = book.nombre
        lblAuthorName.text = book.autor
        lblStatus.text = book.disponibilidad == true ? "Disponible" : "No disponible"
        fotoPerfil(urlBookImage: book.imagen!)
    }
    
    func fotoPerfil(urlBookImage: String?) {
        
        if urlBookImage != "" {
            do {
                if urlBookImage != "" {
                    let url = URL(string: urlBookImage!)
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data)
                    bookImage.image = image
                }
            }
            catch {
                print(error)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
