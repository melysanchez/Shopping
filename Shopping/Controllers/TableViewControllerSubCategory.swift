//
//  TableViewControllerSubCategory.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 4/4/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import Firebase

class TableViewControllerSubCategory: UITableViewController {
    
    var subcategory = [SubCategory]()
    var selectedCategory: String?
    var selectedDepartment: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("selectedDepartment: \(selectedDepartment)")
        print("selectedCategory : \(selectedCategory)")
        
        loadData()
        tableView.separatorStyle = .none
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subcategory.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath)
        
        let item = subcategory[indexPath.row]
        cell.textLabel?.text = item.displayname
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subCateSelected = subcategory[indexPath.row].displayname
        // print("SUBCATESELECTED CATEGORY: \(String(describing: subCateSelected))")
    }
    
    //MARK: FireBaseData
    func loadData(){
        let ref = Database.database().reference()
        var tempArray = [SubCategory]()
        
        //Receive Data from Firebase
        ref.child("SubCategory").observe(.value) { [weak self] (data) in
            if let array =  data.value as? [String:AnyObject] {
                array.forEach { item in
                    if let item = item.value as? [String:AnyObject] {
                        
                        //  print("ITEM :\(item)")
                        let displayname = item["displayname"] as? String
                        let flagCategory = item["flagCategory"] as? String
                        let flagDepartment = item["flagDepartment"] as? String
                        tempArray.append(SubCategory(displayname: displayname, flagCategory: flagCategory, flagDepartment: flagDepartment))
                    }
                }
            }
            
            DispatchQueue.main.async {
                self?.showData(array: tempArray)
            }
            
        }
    }
    
    func showData(array: [SubCategory]) {
        guard let selectedDepartment = self.selectedDepartment, let selectedCategory = self.selectedCategory else { return }
        
        let subCategoriesFilteredByCategory = array.filter { $0.flagCategory == selectedCategory }
        subCategoriesFilteredByCategory.forEach { (subCategory) in
            guard let departamentos = subCategory.flagDepartment else { return }
            if departamentos.contains(selectedDepartment){
                self.subcategory.append(subCategory)
            }
        }
        
        self.tableView.reloadData()
    }
    
    
}
