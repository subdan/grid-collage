//
//  CreateCollageViewController.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit
import Nuke

class CreateCollageViewController: UIViewController {

    var accessToken: String?
    var secureStorage: SecureStorage?
    
    // MARK: - Navigation Items
    
    private var logoutButton: UIBarButtonItem?
    private var shareButton: UIBarButtonItem?
    
    // MARK: - Services
    
    private lazy var instagramImageService = { return InstagramImageService() }()
    private var pendingServiceCalls = [ServiceCall]()
    
    // MARK: - Models
    
    private var imagesCollectionPresentationModel: ImagesCollectionPresentationModel?
    private var collagePresentationModel = CollagePresentationModel()
    
    // MARK: - ViewController Lifecycle
    
    public var rootView: CreateCollageView { return self.view as! CreateCollageView }
    
    override func loadView() {
        self.view = CreateCollageView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pendingServiceCalls.forEach { $0.cancel() }
        pendingServiceCalls.removeAll()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        
        rootView.collectionView.delegate = self
        
        guard let accessToken = accessToken else { return }
        let serviceCall = instagramImageService.obtainRecentImagesSortedByLikes(accessToken: accessToken) { [weak self] instaImages in
            
            self?.imagesCollectionPresentationModel = ImagesCollectionPresentationModel(with: instaImages)
            self?.rootView.collectionView.dataSource = self?.imagesCollectionPresentationModel!
            self?.rootView.collectionView.reloadData()
            
            self?.rootView.collageCollectionView.dataSource = self?.collagePresentationModel
        }
        pendingServiceCalls.append(serviceCall)
    }
    
    // MARK: - Actions
    
    @objc func shareTapAction() {
        if let collageType = rootView.getCollageType() {
//            let image = CollageMaker.make(collagePresentationModel.getCollageImages())
//            let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//            navigationController?.present(activity, animated: true, completion: nil)
        }
    }
    
    @objc func logoutTapAction() {
        // Clear memory cache
        ImageCache.shared.removeAll()
        // Clear disk cache
        DataLoader.sharedUrlCache.removeAllCachedResponses()
        // Clear website data such as cookies, caches etc.
        InstagramWebKitData.remove()
        // Delete accessToken from the Keychain
        secureStorage?.deleteAccessToken()
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Method
    
    private func setupViewController() {
        logoutButton = UIBarButtonItem(title: NSLocalizedString("LogoutButton", comment: ""),
                                       style: .plain,
                                       target: self,
                                       action: #selector(logoutTapAction))
        shareButton = UIBarButtonItem(barButtonSystemItem: .action,
                                      target: self,
                                      action: #selector(shareTapAction))
        shareButton?.isEnabled = false
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = shareButton
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = NSLocalizedString("Collage", comment: "")
    }
    
    private func updateShareButtonIsEnable() {
        let selectedItemsCount = rootView.collectionView.indexPathsForSelectedItems?.count ?? 0
        let requiredItemsCount = imagesCollectionPresentationModel?.requiredImagesForCollage
        shareButton?.isEnabled = selectedItemsCount == requiredItemsCount
    }
    
}

// MARK: - UICollectionViewDelegate

extension CreateCollageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let instaImage = imagesCollectionPresentationModel?.instaImage(for: indexPath) {
            collagePresentationModel.appendImage(instaImage, indexPath)
            rootView.collageCollectionView.reloadData()
        }
        updateShareButtonIsEnable()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collagePresentationModel.removeImage(at: indexPath)
        rootView.collageCollectionView.reloadData()
        updateShareButtonIsEnable()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let indexPaths = collectionView.indexPathsForSelectedItems {
            return indexPaths.count < imagesCollectionPresentationModel!.requiredImagesForCollage
        } else {
            return false
        }
    }
}
