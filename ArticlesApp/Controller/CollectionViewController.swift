//
//  CollectionViewController.swift
//  CollectionViewDemo3
//
//  Created by camilo andres ibarra yepes on 21/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import UIKit
import Toast_Swift

private let reuseIdentifier = "Cell"

let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var itemsArrayStore = [Article]()
    var itemsArrayToLoad = [Article]()
    var isLoading = false
    
    var articleViewModels = [ArticleViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //SafeArea help
        if #available(iOS 11.0, *) { collectionView?.contentInsetAdjustmentBehavior = .always }
        setLoadingActivityIndicator()
        fetchData()
        
    }
    
    func setLoadingActivityIndicator(){
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
    }
    
    
    fileprivate func fetchData() {
        Service.shared.fetchArticles { (articles, err) in
            if let err = err {
                print("Failed to fetch articles:", err)
                return
            }
            //Check if not conection and there is not data saved
            if(articles == nil){
                self.view.makeToast("No internet conextion, no local info")
            }else{
                //There is conection available
                self.itemsArrayStore = articles!
                do {
                    let data = try JSONEncoder().encode(self.itemsArrayStore)
                    UserDefaults.standard.set(data, forKey : "articles")
                    print("dataquees", type(of: data))
                } catch { print(error) }
            }
            self.articleViewModels = articles?.map({return ArticleViewModel(article: $0)}) ?? []
            self.loadData()
            self.collectionView.reloadData()
        }
    }
    
    func loadData() {
        
        self.isLoading = false
        let updateLimit = 21
        
        if itemsArrayStore.count != 0 {
            for i in 0..<updateLimit {
                itemsArrayToLoad.append(itemsArrayStore[i])
                print("isabella", itemsArrayStore[i])
            }
        }
        self.collectionView.reloadData()
    }
    
    func loadMoreData(loadItems: Int) {
        
        if !self.isLoading {
            self.isLoading = true
            activityIndicator.startAnimating()
            
            let start = itemsArrayToLoad.count
            let end = start + loadItems
            
            DispatchQueue.global().async {
                sleep(2)
                for i in start...end {
                    self.itemsArrayToLoad.append(self.itemsArrayStore[i])
                }
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsArrayToLoad.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        detailVC?.titleDetail = articleViewModels[indexPath.row].title
        detailVC?.DescriptionDetail = articleViewModels[indexPath.row].content
        detailVC?.hourDetail = articleViewModels[indexPath.row].publishedAt
        detailVC?.imageDetail = articleViewModels[indexPath.row].urlToImage
        detailVC?.sourceName = articleViewModels[indexPath.row].nameSource
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = itemsArrayToLoad.count - 1
        if indexPath.row == lastElement {
            let differenceToLoad = (itemsArrayStore.count - itemsArrayToLoad.count)-1
            if differenceToLoad < 0 { self.view.makeToast("No more items") }else{ loadMoreData(loadItems: differenceToLoad) }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        _ = itemsArrayToLoad[indexPath.row]
        cell.setData(articleViewModel: articleViewModels[indexPath.row])
        return cell
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let orientation = UIApplication.shared.statusBarOrientation
        let screenSize: CGRect = UIScreen.main.bounds
        
        if indexPath.item == 0 || indexPath.item % 7 == 0 {
            
            if(orientation == .landscapeLeft || orientation == .landscapeRight)
            {
                if UIDevice.current.hasNotch {
                    return CGSize(width: (view.frame.width) - 110, height: 200)
                } else {
                    return CGSize(width: (view.frame.width) - 20, height: 200)
                }
            }else {
                return CGSize(width: (view.frame.width) - 20, height: 200)
            }
        }
        
        if(orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            if UIDevice.current.hasNotch {
                return CGSize(width: (view.frame.width / 3.35) - 16, height: 200)
            }else {
                return CGSize(width: (view.frame.width / 3) - 16, height: 200)
            }
            
        }
        
        var widthCell = 0
        var heightCell = 0
        
        //Iphone X, 6, 7, 8
        if screenSize.width == 375 {
            widthCell = 172
            heightCell = 204
        }
        
        //Iphone 6+, 7+, 8+
        if screenSize.width == 414 {
            widthCell = 192
            heightCell = 204
        }
        
        //Every other iphone
        if screenSize.width == 320 {
            widthCell = 144
            heightCell = 204
        }
        
        return CGSize(width: widthCell, height: heightCell)
        
    }
    

}
