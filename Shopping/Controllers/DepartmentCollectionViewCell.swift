//
//  CollectionViewCell.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 4/2/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import Firebase

class DepartmentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var departmentsImageView: UIImageView!
    @IBOutlet weak var departmentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(displayName: String, imageURL: String) {
        departmentsLabel.text = displayName
        downloadImageFromStorage(urlString: imageURL)
    }
    
    private func downloadImageFromStorage(urlString: String) {
        let storage = Storage.storage(url: "gs://shopping-8b3a9.appspot.com")
        let ref = storage.reference(forURL: urlString)
        
        ref.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if let error = error {
                print(error)
            } else {
                let imagedownload = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.departmentsImageView.image = imagedownload
                }
            }
        }
    }
}
