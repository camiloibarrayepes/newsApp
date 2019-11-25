//
//  ArticlesAppTests.swift
//  ArticlesAppTests
//
//  Created by camilo andres ibarra yepes on 24/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import XCTest
@testable import ArticlesApp

class ArticlesAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticleViewModel() {
        let article = Article(title: "titleArticle", content: "contentArticle", publishedAt: "publishedAtArticle", urlToImage: "utlToImageArticle", source: nil)
        
        let articleViewModel = ArticleViewModel(article: article)
        
        guard let getDate = article.publishedAt!.toDate() else { return }
        let hours = differenceBtw(dateStart: getDate, dateEnd: Date())
        
        XCTAssertEqual(article.title, articleViewModel.title)
        XCTAssertEqual(article.content, articleViewModel.content)
        XCTAssertEqual(article.publishedAt, "\(hours) hours" )
        XCTAssertEqual(article.urlToImage, articleViewModel.urlToImage)
        
    }
    
    

}
