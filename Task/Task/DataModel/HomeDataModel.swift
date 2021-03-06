//
//  HomeDataModel.swift
//  Task
//
//  Created by apple on 29/06/22.
//

import Foundation

// MARK: - CanadaDataModel
struct CanadaDataModel: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Row
struct Row: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
