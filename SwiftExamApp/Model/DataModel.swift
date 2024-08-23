//
//  DataModel.swift
//  SwiftExamApp
//
//  Created by Tinku Sardar on 23/08/24.
//

import Foundation

// MARK: - DataModel

struct DataModel: Decodable {
    let entries: [entriesData]?
}
// MARK: - Entry

struct entriesData : Decodable{
    let type     : String?
    let title    : String?
    let picture  : picture?
}

// MARK: - Picture

struct picture : Decodable{
    let url : String?
}


