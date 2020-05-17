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
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
    }
    
    func setup(displayName: String, imageURL: String) {
        departmentsLabel.text = displayName
        ImageService().downloadImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .success(let departmentsImage):
                self?.departmentsImageView.image = departmentsImage
            case .failure(let error):
                print(error)
            }
        }
    }
}
