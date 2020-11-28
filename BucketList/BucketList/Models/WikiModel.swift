//
//  WikiModel.swift
//  BucketList
//
//  Created by Thomas Kellough on 11/28/20.
//

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
