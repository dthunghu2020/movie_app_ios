//
//  ArrayObjectEntity.swift
//  MovieAppIOS
//
//  Created by hungdt on 23/02/2023.
//

import Foundation

struct ArrayResponeEntity<T: Decodable> : Decodable{
    let page: Int?
    let results: [T]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
