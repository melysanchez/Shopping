//
//  ViewController.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 1/31/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerDepartments: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
  
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let departments = ["Men", "Women","Boy","Girl"]
    
    let departmentsImages: [UIImage] = [
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

            // self.navigationController?.navigationBar.tintColor = .white
    }
  
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }

    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDepartments", for: indexPath) as! DepartmentCollectionViewCell
      
        cell.departmentsLabel.text = departments[indexPath.item]
        cell.departmentsImageView.image = departmentsImages[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
           
      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let itemselecter = indexPath.item
        print("item selecter : \(itemselecter)")
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
        performSegue(withIdentifier: "goToCategory", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
}

extension ViewControllerDepartments: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)
    }
    
}

