//
//  ImageService.swift
//  Shopping
//
//  Created by Katherynne Hidalgo on 5/9/20.
//  Copyright © 2020 Katherynne H. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ImageService {
    
    func downloadImage(with urlString: String, completion: @escaping(Result<UIImage,Error>)->Void) {
        let storage = Storage.storage(url: "gs://shopping-8b3a9.appspot.com")
        
            let ref = storage.reference(forURL: urlString)
            
            ref.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let imagedownload = UIImage(data: data!)
                    DispatchQueue.main.async {
                        completion(.success(imagedownload!))
                    }
                }
            }
    }
}
