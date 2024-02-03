//
//  CountryModel.swift
//  ECommerce
//
//  Created by Alex on 2.07.2023.
//

import Foundation

typealias Countries = [Country]

struct Country: Codable, Comparable {
    let name: CountryName
    
    static func < (lhs: Country, rhs: Country) -> Bool {
        return lhs.name < rhs.name
        }
}

struct CountryName: Codable, Comparable {
    let common: String
    
    static func < (lhs: CountryName, rhs: CountryName) -> Bool {
        return lhs.common < rhs.common
        }
}
