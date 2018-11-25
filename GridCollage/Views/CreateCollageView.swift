//
//  CreateCollageView.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 05/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class CreateCollageView: UIView {

    let numOfColumns = 3
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let gap: CGFloat = 2.0
        layout.minimumInteritemSpacing = gap
        layout.minimumLineSpacing = 3.0
        layout.headerReferenceSize = CGSize.zero
        layout.sectionInset = UIEdgeInsets.zero
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseId)
        return collectionView
    }()
    
    lazy var collageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        layout.scrollDirection = .horizontal
        collectionView.allowsSelection = false
        collectionView.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RegularGridCollageCell.self, forCellWithReuseIdentifier: RegularGridCollageCell.reuseId)
        collectionView.register(HorizontalStackCollageCell.self, forCellWithReuseIdentifier: HorizontalStackCollageCell.reuseId)
        collectionView.register(VerticalStackCollageCell.self, forCellWithReuseIdentifier: VerticalStackCollageCell.reuseId)
        return collectionView
    }()
    
    private var peekDelegate: PeekCollectionViewDelegate!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = Int(bounds.width) / numOfColumns - (numOfColumns - 1)
        collectionViewLayout.itemSize = CGSize(width: size, height: size)
    }
    
    // MARK: - Public methods
    
    func getCollageType() -> CollageType? {
        if let indexPaths = collageCollectionView.indexPathsForSelectedItems {
            if let indexPath = indexPaths.first {
                return CollageType.init(rawValue: indexPath.row)
            }
        }
        return nil
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = UIColor.white
        addSubview(collectionView)
        addSubview(collageCollectionView)
        
        peekDelegate = PeekCollectionViewDelegate()
        peekDelegate.delegate = self
        collageCollectionView.delegate = peekDelegate
        
        NSLayoutConstraint.activate([
            collageCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collageCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collageCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collageCollectionView.heightAnchor.constraint(equalTo: collageCollectionView.widthAnchor, constant: -peekDelegate.spaceWidth),
            
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: collageCollectionView.bottomAnchor)
        ])
    }

}

extension CreateCollageView: PeekDelegate {
    func didPeek(_ peek: PeekCollectionViewDelegate,
                 didChangeActiveIndexTo activeIndex: Int) {
        print(activeIndex)
    }
}
