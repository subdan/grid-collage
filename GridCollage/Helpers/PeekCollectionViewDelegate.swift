//
//  MSPeekCollectionViewDelegate.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 11/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

public protocol PeekDelegate: AnyObject {
    func didPeek(_ peek: PeekCollectionViewDelegate, didChangeActiveIndexTo activeIndex: Int)
}

open class PeekCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    public let cellPeekWidth: CGFloat
    public let cellSpacing: CGFloat
    public let scrollThreshold: CGFloat
    public let maximumItemsToScroll: Int
    public let numberOfItemsToShow: Int
    public let scrollDirection: UICollectionView.ScrollDirection
    
    public weak var delegate: PeekDelegate?
    
    private var currentScrollOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    private lazy var itemWidth: (UIView) -> CGFloat = {
        view in
        var frameWidth: CGFloat = self.getViewWidth(view)
        //Get the total remaining width for the
        let itemsWidth = (frameWidth
            //If we have 2 items, there will be 3 spacing and so on
            - (CGFloat(self.numberOfItemsToShow + 1) * (self.cellSpacing))
            //There's always 2 peeking cells even if there are multiple cells showing
            - 2 * (self.cellPeekWidth))
        //Divide the remaining space by the number of items to get each item's width
        let finalWidth = itemsWidth / CGFloat(self.numberOfItemsToShow)
        return max(0, finalWidth)
    }
    
    var spaceWidth: CGFloat {
        return cellPeekWidth * 2 + cellSpacing * 2
    }
    
    private func getViewWidth(_ view: UIView) -> CGFloat {
        switch scrollDirection {
        case .horizontal:
            return view.frame.size.width
        case .vertical:
            return view.frame.size.height
        }
    }
    
    private func getValueFromPoint(_ point: CGPoint) -> CGFloat {
        switch scrollDirection {
        case .horizontal:
            return point.x
        case .vertical:
            return point.y
        }
    }
    
    private func getValueFromSize(_ size: CGSize) -> CGFloat {
        switch scrollDirection {
        case .horizontal:
            return size.width
        case .vertical:
            return size.height
        }
    }
    
    private func getPointFromValue(_ value: CGFloat, defaultPoint: CGPoint) -> CGPoint {
        switch scrollDirection {
        case .horizontal:
            return CGPoint(x: value, y: defaultPoint.y)
        case .vertical:
            return CGPoint(x: defaultPoint.x, y: value)
        }
    }
    
    private func getSizeFromValue(_ value: CGFloat, defaultSize: CGSize) -> CGSize {
        switch scrollDirection {
        case .horizontal:
            return CGSize(width: value, height: defaultSize.height)
        case .vertical:
            return CGSize(width: defaultSize.width, height: value)
        }
    }
    
    private func getEdgeInsets() -> UIEdgeInsets {
        let insets = cellSpacing + cellPeekWidth
        switch scrollDirection {
        case .horizontal:
            return UIEdgeInsets(top: 0, left: insets, bottom: 0, right: insets)
        case .vertical:
            return UIEdgeInsets(top: insets, left: 0, bottom: insets, right: 0)
        }
    }
    
    public init(cellSpacing: CGFloat = 20, cellPeekWidth: CGFloat = 20, scrollThreshold: CGFloat = 50, maximumItemsToScroll: Int = 1, numberOfItemsToShow: Int = 1, scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        self.cellSpacing = cellSpacing
        self.cellPeekWidth = cellPeekWidth
        self.scrollThreshold = scrollThreshold
        self.maximumItemsToScroll = maximumItemsToScroll
        self.numberOfItemsToShow = numberOfItemsToShow
        self.scrollDirection = scrollDirection
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let viewWidth = getViewWidth(scrollView)
        guard viewWidth > 0 else {
            return
        }
        let target = targetContentOffset.pointee
        //Current scroll distance is the distance between where the user tapped and the destination for the scrolling (If the velocity is high, this might be of big magnitude)
        let currentScrollDistance = getValueFromPoint(target) - getValueFromPoint(currentScrollOffset)
        let coefficient = calculateCoefficient(scrollDistance: currentScrollDistance, scrollWidth: itemWidth(scrollView))
        
        let adjacentItemNumber = self.scrollView(scrollView, indexForItemAtContentOffset: currentScrollOffset) + coefficient
        let adjacentItemOffsetX = self.scrollView(scrollView, contentOffsetForItemAtIndex: adjacentItemNumber)
        
        targetContentOffset.pointee = getPointFromValue(adjacentItemOffsetX, defaultPoint: target)
        
        //Get the new active index
        let activeIndex = self.scrollView(scrollView, indexForItemAtContentOffset: targetContentOffset.pointee)
        //Pass the active index to the delegate
        delegate?.didPeek(self, didChangeActiveIndexTo: activeIndex)
    }
    
    open func scrollView(_ scrollView: UIScrollView, indexForItemAtContentOffset contentOffset: CGPoint) -> Int {
        let width = itemWidth(scrollView) + cellSpacing
        guard width > 0 else {
            return 0
        }
        let offset = self.getValueFromPoint(contentOffset)
        let index = Int(round(offset/width))
        return index
    }
    
    open func scrollView(_ scrollView: UIScrollView, contentOffsetForItemAtIndex index: Int) -> CGFloat{
        return CGFloat(index) * (itemWidth(scrollView) + cellSpacing)
    }
    
    private func calculateCoefficient(scrollDistance: CGFloat, scrollWidth: CGFloat) -> Int {
        var coefficent = 0
        let safeScrollThreshold = max(scrollThreshold, 0.1)
        if abs(scrollDistance/safeScrollThreshold) <= 1 {
            coefficent = Int(scrollDistance/safeScrollThreshold)
        }
        else if Int(abs(scrollDistance/scrollWidth)) == 0 {
            coefficent = max(-1, min(Int(scrollDistance/safeScrollThreshold), 1))
        }
        else {
            coefficent = Int(scrollDistance/scrollWidth)
        }
        let finalCoefficent = max((-1) * maximumItemsToScroll, min(coefficent, maximumItemsToScroll))
        return finalCoefficent
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getSizeFromValue(itemWidth(collectionView), defaultSize: collectionView.frame.size)
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return getEdgeInsets()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentScrollOffset = scrollView.contentOffset
    }
}
