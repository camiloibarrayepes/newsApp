//
//  ArticleViewModel.swift
//  CollectionViewDemo3
//
//  Created by camilo andres ibarra yepes on 22/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import Foundation
import UIKit

struct ArticleViewModel {
    
    let title: String
    let content: String
    let publishedAt: String
    let urlToImage: String
    let nameSource: String
    
    // Dependency Injection (DI)
    init(article: Article) {
        
        //get DateString and convert to Date Type
        let getDate = article.publishedAt!.toDate()
        //get the hours difference Between
        let hours = differenceBtw(dateStart: getDate ?? Date(), dateEnd: Date())
        
        self.title = article.title ?? "Title Defualt"
        self.content = article.content ?? "Content Default"
        self.publishedAt = "\(hours) hours"
        self.nameSource = article.source?.name ?? "From"
        self.urlToImage = article.urlToImage ?? "https://discountseries.com/wp-content/uploads/2017/09/default.jpg"
    }
}

func differenceBtw(dateStart: Date, dateEnd: Date) -> Int {
    let diff = Int(dateEnd.timeIntervalSince1970 - dateStart.timeIntervalSince1970)
    let hours = diff / 3600
    //let minutes = (diff - hours * 3600)
    return hours
}
