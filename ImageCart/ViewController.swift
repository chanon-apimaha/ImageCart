//
//  ViewController.swift
//  ImageCart
//
//  Created by Developer Pantip on 22/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var mHeaderView: UIView = {
        let mMainView: UIView = UIView()
        mMainView.backgroundColor = UIColor(hex: "#505968")
        
        let mHeaderLabel: UILabel = UILabel()
//        mHeaderLabel.backgroundColor = .yellow
        mHeaderLabel.textColor = .red
        mHeaderLabel.text = "รายการ"
        mHeaderLabel.textAlignment = .left
        
        let mAddImageButton: UIButton = UIButton()
//        mAddImageButton.backgroundColor = .green
        mAddImageButton.setImage(UIImage(named: "add-image-2"), for: .normal)
        
        mHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        mAddImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        mMainView.addSubview(mHeaderLabel)
        mMainView.addSubview(mAddImageButton)
        
        mHeaderLabel.leftAnchor.constraint(equalTo: mMainView.leftAnchor, constant: 8.0).isActive = true
        mHeaderLabel.topAnchor.constraint(equalTo: mMainView.topAnchor, constant: 8.0).isActive = true
        mHeaderLabel.bottomAnchor.constraint(equalTo: mMainView.bottomAnchor).isActive = true
        mHeaderLabel.rightAnchor.constraint(equalTo: mAddImageButton.leftAnchor, constant: -8.0).isActive = true
        
        mAddImageButton.rightAnchor.constraint(equalTo: mMainView.rightAnchor, constant: -8.0).isActive = true
        mAddImageButton.topAnchor.constraint(equalTo: mMainView.topAnchor, constant: 8.0).isActive = true
        
        mAddImageButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        mAddImageButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        return mMainView
    }()
    
    fileprivate var mTableView: UIView = {
        let mMainView: UITableView = UITableView()
        mMainView.backgroundColor = .red
        
        return mMainView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "คลังภาพ"
        self.edgesForExtendedLayout = []
        
        self.mHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.mTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.mHeaderView)
        self.view.addSubview(self.mTableView)
        
        if #available(iOS 11.0, *) {
            let guide = self.view.safeAreaLayoutGuide
            self.mHeaderView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            self.mHeaderView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
            self.mHeaderView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
            self.mHeaderView.heightAnchor.constraint(equalToConstant: self.view.safeAreaInsets.top + 48.0).isActive = true
            
            self.mTableView.topAnchor.constraint(equalTo: self.mHeaderView.bottomAnchor).isActive = true
            self.mTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            self.mTableView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
            self.mTableView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        } else {
            self.mHeaderView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.mHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.mHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            self.mHeaderView.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
            
            self.mTableView.topAnchor.constraint(equalTo: self.mHeaderView.bottomAnchor).isActive = true
            self.mTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.mTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.mTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        }
    }
}

