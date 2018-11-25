//
//  CollageCell.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 14/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class CollageCell: UICollectionViewCell {
    
    lazy var image1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var image2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var image3: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var image4: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func show(_ collageItem: CollageItemViewModel, at index: Int) {
        if let imageView = getImageView(by: index) {
            let url = URL(string: collageItem.instaImage.url)!
            Nuke.loadImage(with: url,
                           options: ImageLoadingOptions(
                            placeholder: UIImage(named: "placeholder"),
                            transition: .fadeIn(duration: 0.33)),
                           into: imageView)
        }
    }
    
    func remove(at index: Int) {
        if let imageView = getImageView(by: index) {
            imageView.image = nil
        }
    }
    
    func getCollageImages() -> [UIImage] {
        return [image1.image!, image2.image!, image3.image!, image4.image!]
    }
    
    override func prepareForReuse() {
        image1.image = nil
        image2.image = nil
        image3.image = nil
        image4.image = nil
    }
    
    func setupView() {
        
    }
    
    func getImageView(by index: Int) -> UIImageView? {
        switch index {
        case 0:
            return image1
        case 1:
            return image2
        case 2:
            return image3
        case 3:
            return image4
        default:
            return nil
        }
    }
    
}
