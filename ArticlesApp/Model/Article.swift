//
//  Article.swift
//  CollectionViewDemo3
//
//  Created by camilo andres ibarra yepes on 21/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String?
    let content: String?
    let publishedAt: String?
    let urlToImage: String?
    let source: Source?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
