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

public typealias UIViewTargetClosure = (UIView) -> ()

public class UIViewClosureWrapper: NSObject {
    let closure: UIViewTargetClosure
    init(_ closure: @escaping UIViewTargetClosure) {
        self.closure = closure
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIViewTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIViewClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIViewClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func addTargetClosure(closure: @escaping UIViewTargetClosure) {
        targetClosure = closure
        
        let oImageAction = UITapGestureRecognizer(target: self, action: #selector(UIView.UIViewclosureAction))
        self.isUserInteractionEnabled = true
        addGestureRecognizer(oImageAction)
    }
    
    @objc public func UIViewclosureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}
