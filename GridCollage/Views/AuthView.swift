//
//  EnterNameView.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 04/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class AuthView: UIView {

    lazy var loginButton: UIButton = {
        let button = RoundRectButton()
        button.setBackgroundColor(#colorLiteral(red: 0.2196078431, green: 0.5921568627, blue: 0.9411764706, alpha: 1), for: UIButton.State.normal)
        button.setBackgroundColor(#colorLiteral(red: 0.1539016859, green: 0.414984903, blue: 0.6595786538, alpha: 1), for: UIButton.State.highlighted)
        button.setTitle(NSLocalizedString("LoginButton", comment: ""), for: UIButton.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("LoginLabel", comment: "")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var instagramImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "instagram_logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var gradientLayer: CAGradientLayer!
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        createGradientLayer()
        addSubview(loginButton)
        addSubview(loginLabel)
        addSubview(instagramImage)
        setupConstraints()
    }
    
    // MARK: - Overriden methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Private methods
   
    private func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            #colorLiteral(red: 0.7019607843, green: 0, blue: 0.5882352941, alpha: 1).cgColor, #colorLiteral(red: 0.8862745098, green: 0, blue: 0.4196078431, alpha: 1).cgColor, #colorLiteral(red: 0.9333333333, green: 0, blue: 0.3058823529, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.2666666667, blue: 0.1333333333, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.631372549, blue: 0.2078431373, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.4, 0.6, 0.8, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            instagramImage.widthAnchor.constraint(equalToConstant: 100),
            instagramImage.heightAnchor.constraint(equalToConstant: 100),
            instagramImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            instagramImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),

            loginLabel.topAnchor.constraint(equalTo: instagramImage.bottomAnchor, constant: 64),
            loginLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),

            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
