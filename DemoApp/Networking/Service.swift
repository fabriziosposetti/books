//
//  Service.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import Alamofire

typealias HandleBooksResponse = (ServiceResponse?, String?) -> Void


public class Service {
    
    public static let instance = Service()
    
     func getBooks(completionHandler: @escaping HandleBooksResponse) {
        let urlRequest = Deal.instance.getBooksUrl()
        AF.request(urlRequest)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            print(response.data)
                            let decoder = JSONDecoder()
                            let serviceResponse = try decoder.decode(ServiceResponse.self, from: data)
                            completionHandler(serviceResponse, nil)
                        }
                    } catch let error {
                        completionHandler(nil, Text.Error.description + error.localizedDescription)
                    }
                case .failure(let error):
                    completionHandler(nil, error.localizedDescription)
                }
        }
        
    }
    
}
