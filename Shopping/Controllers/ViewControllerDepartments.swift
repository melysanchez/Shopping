//
//  ViewController.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 1/31/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit

class ViewControllerCategory: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let categories = ["Men", "Women","Boy","Girl"]
    
    let categoriesImages: [UIImage] = [
        UIImage(named:"men")!,
        UIImage(named:"women")!,
        UIImage(named:"boy")!,
        UIImage(named:"girl")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)

        self.navigationController?.navigationBar.tintColor = .white
    }
  
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCategory", for: indexPath) as! CollectionViewCell
       
        cell.categoryLabel.text = categories[indexPath.item]
        cell.categoryImageView.image = categoriesImages[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
      return cell
    }

}

