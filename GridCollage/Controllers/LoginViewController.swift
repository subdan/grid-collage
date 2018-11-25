//
//  LoginsViewController.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: GenericViewController<LoginView>, WKNavigationDelegate {
    
    var completion: ((String) -> Void)?
    
    // MARK: - ViewControlelr Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTap)
        )
        
        title = NSLocalizedString("LoginTitle", comment: "")
        
        rootView.webView.navigationDelegate = self
        
        showAuthPage()
    }
    
    // MARK: - Actions
    
    @objc func cancelTap() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func showAuthPage() {
        if let url = InstagramURLBuilder.getAuthURL() {
            let request = URLRequest(url: url)
            rootView.webView.load(request)
        }
    }
    
    private func processAccessTokenURLFragment(_ fragment: String) {
        let range: Range<String.Index> = fragment.range(of: "access_token=")!
        let accessToken = String(fragment[range.upperBound...])
        dismiss(animated: true, completion: nil)
        completion?(accessToken)
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        rootView.activityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        rootView.activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }

        if url.host == InstagramURLBuilder.redirectHost {
            if let fragment = url.fragment {
                processAccessTokenURLFragment(fragment)
                decisionHandler(.cancel)
                return
            }
        }

        decisionHandler(.allow)
    }
    
}
