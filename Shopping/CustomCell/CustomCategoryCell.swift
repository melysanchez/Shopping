//
//  CustomCellTableViewCell.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 5/4/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import Firebase

class CustomCategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryImageView.layer.cornerRadius = categoryImageView.frame.size.height / 2
        categoryImageView.layer.masksToBounds = true
        categoryImageView.layer.borderWidth = 1
        categoryImageView.layer.borderColor = UIColor.darkGray.cgColor
    }

    func setup(name: String, imageURL: String) {
        categoryName.text = name
        ImageService().downloadImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .success(let categoryImage):
                self?.categoryImageView.image = categoryImage
            case .failure(let error):
                print(error)
            }
        }
    }
}


