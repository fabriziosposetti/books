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
    var btnActions: UIBarButtonItem?
    @IBOutlet weak var switchAll: UISwitch!
    @IBOutlet weak var switchAvailable: UISwitch!
    @IBOutlet weak var switchNoAvailable: UISwitch!
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    var books: [Book]?
    var originalBooks: [Book]?
    var filteredBooks = [Book]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Text.Libros.description
        configureTableView()
        getBooks()
        addNavigationActions()
        
        switchAvailable.isOn = false
        switchNoAvailable.isOn = false
    }
    
    private func configureTableView() {
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.register(UINib(nibName: BookTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: BookTableViewCell.nibName)
        booksTableView.tableFooterView = UIView()
    }
    
    private func addNavigationActions() {
        self.btnActions = UIBarButtonItem(title: Text.Acciones.description,
                                             style: .plain,
                                             target: self,
                                             action: #selector(showActions))
        btnActions?.isEnabled = true
        navigationItem.rightBarButtonItem = btnActions!
    }
    
    @IBAction func switchNoAvailableTapped(_ sender: UISwitch) {
        if switchNoAvailable.isOn {
            switchAll.isOn = false
            switchAvailable.isOn = false
            filteredBooks = (originalBooks?.filter({ $0.disponibilidad == false }))!
            self.books = filteredBooks.sorted(by: { $0.popularidad > $1.popularidad })
            self.booksTableView.reloadData()
            
        }
    }
    
    @IBAction func switchAllTapped(_ sender: Any) {
        if switchAll.isOn {
            switchAvailable.isOn = false
            switchNoAvailable.isOn = false
            self.books = self.originalBooks?.sorted(by: { $0.popularidad > $1.popularidad })
            self.booksTableView.reloadData()
        }
    }
    
    
    @IBAction func switchAvailableTapped(_ sender: UISwitch) {
        if switchAvailable.isOn {
            switchAll.isOn = false
            switchNoAvailable.isOn = false
            filteredBooks = (originalBooks?.filter({ $0.disponibilidad == true }))!
            self.books = filteredBooks.sorted(by: { $0.popularidad > $1.popularidad })
            self.booksTableView.reloadData()
        }
    }
    
    @objc func showActions() {
        let alertCotroller = UIAlertController(title: nil,
                                               message: nil,
                                               preferredStyle: .actionSheet)
        
        
        let cancelAction = UIAlertAction(title: Text.Cancelar.description,
                                           style: .default,
                                           handler: nil)
        
        let reverseBookOrder = UIAlertAction(title: Text.InvertirOrden.description,
                                             style: .default, handler: { [weak self] _ in
                                                guard let self = self else { return }
                                                self.reverseBookOrder()
        })
        
        alertCotroller.addAction(reverseBookOrder)
        alertCotroller.addAction(cancelAction)
        self.present(alertCotroller, animated: true, completion: nil)
    }
    
    
    private func reverseBookOrder() {
        self.books?.reverse()
        self.booksTableView.reloadData()
    }
    
    private func getBooks() {
        showActivityIndicator(activityIndicator: activityIndicator)
        DAO.instance.getBooks { [weak self] response, error in
            guard let self = self else { return }
            self.stopActivityIndicator(activityIndicator: self.activityIndicator)
            if error == nil {
                self.originalBooks = response
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

