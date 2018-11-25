//
//  GenericViewController.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

open class GenericViewController<GenericView: UIView>: UIViewController {
    
    public var rootView: GenericView { return self.view as! GenericView }
    
    override open func loadView() {
        self.view = GenericView(frame: UIScreen.main.bounds)
    }
    
}
