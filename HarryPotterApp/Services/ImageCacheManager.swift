//
//  ImageCacheManager.swift
//  HarryPotterApp
//
//  Created by Anikin Ilya on 20.10.2022.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
