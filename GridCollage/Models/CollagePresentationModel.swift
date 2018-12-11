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

/// Presentation model for collage collection view
class CollagePresentationModel: NSObject, UICollectionViewDataSource {

    /// images to show
    private var instaImages = [InstaImage?]()
    
    /// maps parent's IndexPath to index of instaImages array
    private var map = [IndexPath: Int]()
    
    func appendImage(_ instaImage: InstaImage, _ parentIndexPath: IndexPath) {
        let index = instaImages.firstIndex { $0 == nil } // first empty pos
        if let index = index {
            instaImages[index] = instaImage
            map[parentIndexPath] = index
        } else {
            instaImages.append(instaImage)
            map[parentIndexPath] = instaImages.count - 1
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
        return CollageType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseId: String
        if indexPath.row == CollageType.regularGrid.rawValue {
            reuseId = RegularGridCollageCell.reuseId
        } else if indexPath.row == CollageType.horizontalStack.rawValue {
            reuseId = HorizontalStackCollageCell.reuseId
        } else {
            reuseId = VerticalStackCollageCell.reuseId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                      for: indexPath) as! CollageCell
        
        if instaImages.count >= 1, let instaImage = instaImages[0] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell.image1)
        }
        if instaImages.count >= 2, let instaImage = instaImages[1] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell.image2)
        }
        if instaImages.count >= 3, let instaImage = instaImages[2] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell.image3)
        }
        if instaImages.count >= 4, let instaImage = instaImages[3] {
            Nuke.loadImage(with: URL(string: instaImage.url)!, into: cell.image4)
        }
        
        return cell
    }
    
}
