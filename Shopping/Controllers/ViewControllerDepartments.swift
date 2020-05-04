//
//  ViewController.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 1/31/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ViewControllerDepartments: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    // Declare instance variables here
     var departments = [DepartmentsClass]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 5,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 5

        loadFirebaseData()
    }
  
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }

    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDepartments", for: indexPath) as! DepartmentCollectionViewCell
        
        cell.setup(displayName: departments[indexPath.item].displayname!, imageURL: departments[indexPath.item].imagenURL!)
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
    
    //MARK: FireBaseData
    func loadFirebaseData(){
        //Creating reference firebasedatabse
        let ref = Database.database().reference()
               
        //Receive Data from Firebase
        ref.child("Departments").observe(.value) { [weak self] (data) in
            if let array =  data.value as? [String:AnyObject] {
                array.forEach { item in
                    if let item = item.value as? [String:AnyObject] {
                        let name = item["displayname"] as? String
                        let imageURL = item["imagen"] as? String
                        self?.departments.append(DepartmentsClass(displayname: name, imagenURL: imageURL))
                    }
                }
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
        }
    
    }

extension ViewControllerDepartments: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: 230)
    }
    
}

