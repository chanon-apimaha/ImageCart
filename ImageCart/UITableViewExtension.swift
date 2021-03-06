//
//  UITableViewExtension.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 24/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit

public extension UITableView {
    public struct insets {
        public static var top: CGFloat = 0.0
        public static var bottom: CGFloat = 0.0
        public static var left: CGFloat = 8.0
        public static var right: CGFloat = 8.0
    }
    
    public struct background {
        public static var color = UIColor(hex: "#f7d176")
    }
    
    public func setDefault(sSeparatorStyle: UITableViewCell.SeparatorStyle = .singleLine, bHaveFooter: Bool = false, separatorInset: UIEdgeInsets = UIEdgeInsets.init(top: UITableView.insets.top, left: UITableView.insets.left, bottom: UITableView.insets.bottom, right: UITableView.insets.right)) {
        self.allowsSelection = true
        self.preservesSuperviewLayoutMargins = false
        self.cellLayoutMarginsFollowReadableWidth = false
        self.separatorInset = separatorInset // ทำเส้นคั่นให้ full width รบกวนใส cell.layoutMargins = UIEdgeInsetsZero ที่ cell ด้วย
        self.layoutMargins = .zero // ทำเส้นคั่นให้ full width รบกวนใส cell.preservesSuperviewLayoutMargins = false ที่ cell ด้วย
        self.separatorStyle = sSeparatorStyle //เปิดไว้ก่อน เวลาทำจริงให้ปิดท้ิง
        if !bHaveFooter {
            let view = UIView()
            view.backgroundColor = .clear
            self.tableFooterView = view //ตัดเส้นคั่นที่เป็น default footer ออก
        }
        self.backgroundColor = UITableView.background.color
        self.separatorColor = UIColor(hex: "#f99325").withAlphaComponent(0.54)
    }
    
    public func performUpdate(_ update: ()->Void, completion: (()->Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        beginUpdates()
        update()
        endUpdates()
        CATransaction.commit()
    }
    
    public func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }
    
}

extension UITableViewCell {
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}

extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}
