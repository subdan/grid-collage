//
//  LoginView.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class LoginView: UIView {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(webView)
        addSubview(activityIndicatorView)
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
    }
}
