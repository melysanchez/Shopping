//
//  TableViewControllerCategory.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 4/4/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class TableViewControllerCategory:UITableViewController{
    
    var categories = [AllCategories]()
    var categorySelected : String?
    var selectedDepartment: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Register your MessageCell.xib file here:
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "customCategoryCell")
        tableView.separatorStyle = .none
        loadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create new design cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCategoryCell", for: indexPath) as? CustomCategoryCell else { return UITableViewCell() }
        
        
        cell.setup(name: categories[indexPath.item].name!, imageURL: categories[indexPath.item].imageurl!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorySelected = categories[indexPath.row].name
        print("ITEM CATEGORY: \(String(describing: categorySelected))")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TableViewControllerSubCategory") as! TableViewControllerSubCategory
        vc.selectedCategory = categorySelected
        vc.selectedDepartment = selectedDepartment
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //MARK: FireBaseData
    func loadData(){
        let ref = Database.database().reference()
        
        //Receive Data from Firebase
        ref.child("Category").observe(.value) { [weak self] (data) in
            if let array =  data.value as? [String:AnyObject] {
                array.forEach { item in
                    if let item = item.value as? [String:AnyObject] {
                        let name = item["name"] as? String
                        let imageURL = item["image"] as? String
                        self?.categories.append(AllCategories(name: name,imageurl: imageURL))
                    }
                    
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
    }
}
