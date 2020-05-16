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
    var departments = [Departments]()
    var departmentSelected : String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 20,left: 10,bottom: 20,right: 10)
        layout.minimumInteritemSpacing = 10
        
        loadFirebaseData()
    }
    
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDepartments", for: indexPath) as! DepartmentCollectionViewCell
        
        cell.setup(displayName: departments[indexPath.item].displayname!, imageURL: departments[indexPath.item].imagenURL!)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        departmentSelected = departments[indexPath.item].displayname
        print("SELECCIONADO : \(String(describing: departmentSelected))")
        
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 1
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TableViewControllerCategory") as! TableViewControllerCategory
        vc.selectedDepartment = departmentSelected
        self.navigationController?.pushViewController(vc, animated: true)
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
        var tempArray = [Departments]()
        //Receive Data from Firebase
        ref.child("Departments").observe(.value) { [weak self] (data) in
            if let array =  data.value as? [String:AnyObject] {
                array.forEach { item in
                    if let item = item.value as? [String:AnyObject] {
                        let name = item["displayname"] as? String
                        let imageURL = item["imagen"] as? String
                        tempArray.append(Departments(displayname: name, imagenURL: imageURL))
                    }
                }
            }
            DispatchQueue.main.async {
                self?.departments = tempArray.sorted(by: { (dep1, dep2) -> Bool in
                    return dep1.displayname! < dep2.displayname!
                })
                self?.collectionView.reloadData()
            }
            
        }
    }
    
}

extension ViewControllerDepartments: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.collectionView.frame.size.width - 40)/2, height: 200)
    }
    
}

