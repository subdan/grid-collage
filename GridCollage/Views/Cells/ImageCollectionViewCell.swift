//
//  ImageCollectionViewCell.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "image_cell"
    
    var selectionImageView: UIImageView = {
        var view = UIImageView()
        view.image = #imageLiteral(resourceName: "selector_2")
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "placeholder")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var likesCounterBGView: UIImageView = {
        var view = UIImageView()
        //view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "likes")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var likesCounterLabel: UILabel = {
        var view = UILabel()
        view.text = "0"
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        view.textColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Overriden
    
    override var isSelected: Bool {
        didSet {
            selectionImageView.isHidden = isSelected == false
            imageView.layer.opacity = isSelected ? 0.7 : 1.0
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
        super.prepareForReuse()
    }
   
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(imageView)
        addSubview(selectionImageView)
        addSubview(likesCounterBGView)
        addSubview(likesCounterLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            selectionImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectionImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectionImageView.topAnchor.constraint(equalTo: topAnchor),
            selectionImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likesCounterBGView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            likesCounterBGView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            likesCounterLabel.centerYAnchor.constraint(equalTo: likesCounterBGView.centerYAnchor),
            likesCounterLabel.leadingAnchor.constraint(equalTo: likesCounterBGView.leadingAnchor, constant: 24),
            
            likesCounterBGView.trailingAnchor.constraint(equalTo: likesCounterLabel.trailingAnchor, constant: 4)
        ])
    }
    
}
