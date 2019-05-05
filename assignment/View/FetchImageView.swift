//
//  FetchImageView.swift
//  assignment
//
//  Created by Anıl on 13.12.2018.
//  Copyright © 2018 Anıl. All rights reserved.
//

import UIKit


class FetchImageView: UIImageView {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var imageUrlString: String?
    
    func loadImage(urlString: String) {
        imageUrlString = urlString
        
        guard let url = URL(string: urlString)
            else
            {
                return
            }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else
                {
                    return
                }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                self.imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
            
        }).resume()
    }
}
