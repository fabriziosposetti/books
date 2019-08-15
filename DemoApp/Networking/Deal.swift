//
//  Deal.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import Foundation

public class Deal {
    
    public static let instance = Deal()
    
    func getBooksUrl() -> URLRequest {
        return URLRequest(url: URL(string: "https://qodyhvpf8b.execute-api.us-east-1.amazonaws.com/test/books")!)
    }
    
}
