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
        self.title = Text.Books.description
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
                self.books = response?.sorted(by: { $0.popularidad > $1.popularidad })
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
            setBookImage(urlBookImage: book.imagen, imageView: cell.bookImage)
            cell.setData(book: book)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let book = books?[indexPath.row] {
            let detailVC: BookDetailViewController = UIStoryboard(name: Storyboards.Main, bundle: nil)
                .instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
            detailVC.book = book
            self.navigationController?.pushViewController(detailVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

