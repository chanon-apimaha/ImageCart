//
//  UIViewExtension.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 24/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit
public extension UIView {
    public var viewController: UIViewController? {
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if (nextResponder is UIViewController) {
                return nextResponder as? UIViewController
            }
        } while nextResponder != nil
        
        return nil
}
}
