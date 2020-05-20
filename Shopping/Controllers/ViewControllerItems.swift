//
//  TableViewControllerItems.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 4/2/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class ViewControllerItems: UIViewController,
UICollectionViewDelegate,UICollectionViewDataSource  {
 

    @IBOutlet weak var CollectionView: UICollectionView!
    
    var selectedCategory: String?
    var selectedDepartment: String?
    var selectedSubCategory: String?
    var selectedItem: String?
    var items = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        let layout = self.CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
           layout.sectionInset = UIEdgeInsets(top: 20,left: 10,bottom: 20,right: 10)
           layout.minimumInteritemSpacing = 10
        
        self.title = selectedSubCategory
        
        loadFirebaseData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellItems", for: indexPath) as! ItemsCVCell
        
        cell.setup(displayName: items[indexPath.item].displayname!, imageURL: items[indexPath.item].imageURL!, price: items[indexPath.item].price,flagSubCategory : items[indexPath.item].flagSubCategory! )
        
         return cell
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        selectedItem = items[indexPath.item].displayname
        
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 1.5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
          let cell = collectionView.cellForItem(at: indexPath)
          cell?.layer.borderColor = UIColor.lightGray.cgColor
          cell?.layer.borderWidth = 0.5
      }
    
     
    //MARK: FireBaseData
       func loadFirebaseData(){
           //Creating reference firebasedatabse
           let ref = Database.database().reference()
           var tempArray = [Items]()
           //Receive Data from Firebase
           ref.child("Items").observe(.value) { [weak self] (data) in
               if let array =  data.value as? [String:AnyObject] {
                   array.forEach { item in
                       if let item = item.value as? [String:AnyObject] {
                           let name = item["displayname"] as? String
                           let imageURL = item["image"] as? String
                           let flagCategory = item["flagCategory"] as? String
                           let flagDepartment = item["flagDepartment"] as? String
                           let flagSubCategory = item["flagSubCategory"] as? String
                           let price = item["price"] as! Int
                           tempArray.append(Items(displayname: name, flagCategory: flagCategory, flagDepartment: flagDepartment, flagSubCategory: flagSubCategory, imageURL: imageURL, price: price))
                       }
                   }
               }
               DispatchQueue.main.async {
                  self?.showData(array: tempArray)
               }
               
           }
       }
    func showData(array: [Items]) {
        guard let selectedDepartment = self.selectedDepartment, let selectedCategory = self.selectedCategory, let selectedSubCategory = self.selectedSubCategory else { return }
          
        
        let itemsFilterBySubCategory = array.filter{$0.flagSubCategory == selectedSubCategory &&
            $0.flagCategory == selectedCategory
        }
        itemsFilterBySubCategory.forEach{ (item) in
            guard let departamentos = item.flagDepartment else { return }
            if departamentos.contains(selectedDepartment){
                self.items.append(item)
            }
        }
        
          self.CollectionView.reloadData()
      }
}

extension ViewControllerItems: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.CollectionView.frame.size.width - 40)/2, height: 200)
    }
    
}

