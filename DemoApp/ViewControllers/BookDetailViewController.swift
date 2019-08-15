//
//  BookDetailViewController.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var book: Book?
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = book?.nombre
        configureData()
    }

    private func configureData() {
        lblBookName.text = book?.nombre
        lblAuthorName.text = book?.autor
        lblStatus.text = book?.disponibilidad == true ? "Disponible" : "No disponible"
        lblPopularity.text = "Popularidad de \(book?.popularidad ?? 0)"
        setBookImage(urlBookImage: book?.imagen, imageView: imageBook)
    }

}
