//
//  ServiceResponse.swift
//  DemoApp
//
//  Created by Fabrizio Sposetti on 15/08/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import Foundation


struct Book: Codable {
    let id: Int?
    let nombre, autor: String?
    let disponibilidad: Bool?
    let popularidad: Int?
    let imagen: String?
}

typealias ServiceResponse = [Book]
