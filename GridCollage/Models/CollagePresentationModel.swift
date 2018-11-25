//
//  CollagePresentationModel.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class CollagePresentationModel: NSObject, UICollectionViewDataSource {
    
    private var instaImages = [InstaImage?]()
    
    private var map = [IndexPath: Int]()
    
    func appendImage(_ instaImage: InstaImage, _ indexPath: IndexPath) {
        let index = instaImages.firstIndex { instaImage -> Bool in
            return instaImage == nil
        }
        if let index = index {
            instaImages[index] = instaImage
            map[indexPath] = index
        } else {
            instaImages.append(instaImage)
            map[indexPath] = instaImages.count - 1
        }
    }
    
    func indexPathToIndex(_ indexPath: IndexPath) -> Int? {
        return map[indexPath]
    }
    
    func removeImage(at indexPath: IndexPath) {
        if let index = indexPathToIndex(indexPath) {
            instaImages[index] = nil
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: CollageCell?
        
        if indexPath.row == CollageType.regularGrid.rawValue {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegularGridCollageCell.reuseId,
                                                      for: indexPath) as? CollageCell
        } else if indexPath.row == CollageType.horizontalStack.rawValue {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalStackCollageCell.reuseId,
                                                      for: indexPath) as? CollageCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalStackCollageCell.reuseId,
                                                          for: indexPath) as? CollageCell
        }
        
        if instaImages.count >= 1, let instaImage = instaImages[0] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell!.image1)
        }
        if instaImages.count >= 2, let instaImage = instaImages[1] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell!.image2)
        }
        if instaImages.count >= 3, let instaImage = instaImages[2] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell!.image3)
        }
        if instaImages.count >= 4, let instaImage = instaImages[3] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell!.image4)
        }
        
        return cell!
    }
    
}
