//
//  DetailViewController.swift
//  CollectionViewDemo3
//
//  Created by camilo andres ibarra yepes on 24/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var camilo: Article?
    
    var titleDetail = ""
    var imageDetail = ""
    var hourDetail = ""
    var DescriptionDetail = ""
    var sourceName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DTitle.text = titleDetail
        guard let urlImageArticleURL = URL(string: imageDetail) else {return}
        DImage.kf.setImage(with: urlImageArticleURL)
        DHour.text = "\(hourDetail) ago"
        DDescription.text = DescriptionDetail
        DSource.text = "From: \(sourceName)"
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBOutlet weak var DImage: UIImageView!
    
    @IBOutlet weak var DTitle: UILabel!
    
    @IBOutlet weak var DHour: UILabel!
    
    @IBOutlet weak var DDescription: UITextView!
    
    @IBOutlet weak var DSource: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
