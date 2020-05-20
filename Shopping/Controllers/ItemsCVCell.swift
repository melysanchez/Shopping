//
//  ItemsCVCell.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 5/18/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import UIKit
import Firebase

class ItemsCVCell: UICollectionViewCell {

    @IBOutlet weak var itemsImageView: UIImageView!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var View: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        View.layer.borderWidth = 0.5
        View.layer.borderColor = UIColor.darkGray.cgColor
        View.layer.cornerRadius = 5
        View.clipsToBounds = true
        
    }
    func setup(displayName: String, imageURL: String, price: Int, flagSubCategory: String) {
        
        itemsLabel.text = displayName
        
        //Change format currency
        let priceFormat = price as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "L"
        //formatter.locale = Locale(identifier: "HNL")
        priceLabel.text = formatter.string(from: priceFormat)
        
          ImageService().downloadImage(with: imageURL) { [weak self] (result) in
              switch result {
              case .success(let itemsImage):
                  self?.itemsImageView.image = itemsImage
              case .failure(let error):
                  print(error)
              }
          }
      }
}
