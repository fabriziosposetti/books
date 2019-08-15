//
//  DAO.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import Foundation

public class DAO {
    
    public static let instance = DAO()
    
     func getBooks(completionHandler: @escaping HandleBooksResponse) {
        Service.instance.getBooks(completionHandler: completionHandler)
    }
    
}
