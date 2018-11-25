//
//  ImagesCollectionPresentationModel.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class ImagesCollectionPresentationModel: NSObject, UICollectionViewDataSource {
    
    var requiredImagesForCollage = 4
    
    private var instaImages: [InstaImage]?
    private var imageRequests = [ImageRequest]()
    
    init(with instaImages: [InstaImage]) {
        self.instaImages = instaImages
        
        for instaImage in instaImages {
            if let url = URL(string: instaImage.url) {
                var request = ImageRequest(url: url)
                request.priority = .high
                imageRequests.append(request)
            }
        }
    }
    
    func instaImage(for indexPath: IndexPath) -> InstaImage? {
        return instaImages?[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instaImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseId,
                                                      for: indexPath)
        
        if let cell = cell as? ImageCollectionViewCell {
            
            if let instaImage = instaImages?[indexPath.row] {
                cell.likesCounterLabel.text = String(instaImage.likes)
            }
            
            let request = imageRequests[indexPath.row]
            Nuke.loadImage(with: request,
                           options: ImageLoadingOptions(
                            placeholder: UIImage(named: "placeholder"),
                            transition: .fadeIn(duration: 0.33)),
                           into: cell.imageView)
        }
        
        return cell
    }
}
