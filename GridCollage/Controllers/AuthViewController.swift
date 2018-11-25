//
//  LaunchScreenViewController.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class AuthViewController: GenericViewController<AuthView> {
    
    var secureStorage: SecureStorage?
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.loginButton.addTarget(self, action: #selector(loginTapAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let accessToken = secureStorage?.getAccessToken() {
            showCreateCollageVC(accessToken)
            return
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Actions
    
    @objc func loginTapAction(_ sender: Any) {
        if let accessToken = secureStorage?.getAccessToken() {
            showCreateCollageVC(accessToken)
            return
        } else {
            showLoginVC()
        }
    }
    
    // MARK: - Private methods
    
    private func showLoginVC() {
        let vc = LoginViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        vc.completion = { [weak self] (accessToken) in
            self?.secureStorage?.saveAccessToken(accessToken)
            self?.showCreateCollageVC(accessToken)
        }
        present(navigationController, animated: true, completion: nil)
    }
    
    private func showCreateCollageVC(_ accessToken: String) {
        let vc = CreateCollageViewController()
        vc.accessToken = accessToken
        vc.secureStorage = secureStorage
        navigationController?.pushViewController(vc, animated: false)
    }
    
}
