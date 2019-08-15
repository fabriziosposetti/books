//
//  ViewController.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var booksTableView: UITableView!
    
    var books: [Book]?
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getBooks()
    }
    
    private func configureTableView() {
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.register(UINib(nibName: BookTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: BookTableViewCell.nibName)
        booksTableView.tableFooterView = UIView()
    }
    
    private func getBooks() {
        showActivityIndicator(activityIndicator: activityIndicator)
        DAO.instance.getBooks { [weak self] response, error in
            guard let self = self else { return }
            self.stopActivityIndicator(activityIndicator: self.activityIndicator)
            if error == nil {
              self.books = response
              self.booksTableView.reloadData()
            }
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        if let book = books?[indexPath.row] {
            cell.setData(book: book)
        }
//        let url = ("\(characterResults?[indexPath.row].thumbnail!.path ?? "")/landscape_large.\(characterResults?[indexPath.row].thumbnail!.thumbnailExtension ?? "value")")
//
//        setImageFrom(url, cell.characterImage)
        return cell
    }
    
    
}

