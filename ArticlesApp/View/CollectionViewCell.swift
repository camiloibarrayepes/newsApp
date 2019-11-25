//
//  CollectionViewCell.swift
//  CollectionViewDemo3
//
//  Created by camilo andres ibarra yepes on 21/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var fromLbl: UILabel!
    
    @IBOutlet weak var hrsAgoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    var articleViewModel: ArticleViewModel! {
        didSet {
            titleLbl?.text = articleViewModel.title
            contentLbl?.text = articleViewModel.content
            hrsAgoLbl?.text = "\(articleViewModel.publishedAt)"
            fromLbl?.text = "\(articleViewModel.nameSource)"
            guard let urlImageArticleURL = URL(string: articleViewModel.urlToImage) else {return}
            cellImageView.kf.setImage(with: urlImageArticleURL)
        }
    }
    
    func setData(articleViewModel: ArticleViewModel){
        self.articleViewModel = articleViewModel
    }
    
}
