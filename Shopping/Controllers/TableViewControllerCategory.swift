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

    var categories = [TestCate]()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        //TODO: Register your MessageCell.xib file here:
//        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "customMCategoryCell")
//
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
        
//           //Create new design cell
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCategoryCell", for: indexPath) as? CustomCategoryCell else { return UITableViewCell() }
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
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
                            self?.categories.append(TestCate(name: name))
                          }
                    
                     }
                 }
                 DispatchQueue.main.async {
                     self?.tableView.reloadData()
                 }
                 
             }
        
    }

       /*
       // Override to support conditional editing of the table view.
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
           return true
       }
       */

       /*
       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
       }
       */

       /*
       // Override to support rearranging the table view.
       override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

       }
       */

       /*
       // Override to support conditional rearranging of the table view.
       override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the item to be re-orderable.
           return true
       }
       */

       /*
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }
       */
}
