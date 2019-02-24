//
//  TableImageCartController.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 22/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit

class TableImageCartController: UIViewController {
    
    var axImageData: [ImageData] = [
        ImageData(image: UIImage(named: "work"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "think"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "slow"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "sad"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "happy"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "diamond"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "passion"), backgroundColor: .blue),
        ImageData(image: UIImage(named: "moterBike"), backgroundColor: .red),
        ImageData(image: UIImage(named: "yogurt"), backgroundColor: .green),
        ImageData(image: UIImage(named: "food"), backgroundColor: .yellow),
    ]
    
    fileprivate var mHeaderView: UIView = {
        let mMainView: UIView = UIView()
        mMainView.backgroundColor = UIColor(hex: "#f99325")
        
        let mHoldButton: UIButton = UIButton()
        let mHeaderLabel: UILabel = UILabel()
        mHeaderLabel.textColor = UIColor(hex: "#f4dfc8")
        mHeaderLabel.text = "คลังรูปภาพของฉัน"
        mHeaderLabel.textAlignment = .center
        
        let mAddImageButton: UIButton = UIButton()
        mAddImageButton.setImage(UIImage(named: "add-image-2"), for: .normal)
        
        mHoldButton.translatesAutoresizingMaskIntoConstraints = false
        mHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        mAddImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        mMainView.addSubview(mHoldButton)
        mMainView.addSubview(mHeaderLabel)
        mMainView.addSubview(mAddImageButton)
        
        mHoldButton.leftAnchor.constraint(equalTo: mMainView.leftAnchor, constant: 16.0).isActive = true
        mHoldButton.topAnchor.constraint(equalTo: mMainView.topAnchor, constant: 8.0).isActive = true
        mHoldButton.bottomAnchor.constraint(equalTo: mMainView.bottomAnchor).isActive = true
        mHoldButton.rightAnchor.constraint(equalTo: mHeaderLabel.leftAnchor, constant: -8.0).isActive = true
        mHoldButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        mHoldButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        mHeaderLabel.topAnchor.constraint(equalTo: mMainView.topAnchor, constant: 8.0).isActive = true
        mHeaderLabel.bottomAnchor.constraint(equalTo: mMainView.bottomAnchor).isActive = true
        mHeaderLabel.rightAnchor.constraint(equalTo: mAddImageButton.leftAnchor, constant: -8.0).isActive = true
        
        mAddImageButton.rightAnchor.constraint(equalTo: mMainView.rightAnchor, constant: -16.0).isActive = true
        mAddImageButton.topAnchor.constraint(equalTo: mMainView.topAnchor, constant: 8.0).isActive = true
        
        mAddImageButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        mAddImageButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        return mMainView
    }()
    
    internal var mTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "คลังภาพ"
    
        self.edgesForExtendedLayout = []
        self.mTableView.setDefault()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.register(TableCellImageCart.self, forCellReuseIdentifier: TableCellImageCart.ReuseIdentifier)
        
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension  TableImageCartController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return axImageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: TableCellImageCart.ReuseIdentifier, for: indexPath) as! TableCellImageCart
        cell.configre(ImageData: axImageData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var fWidth: CGFloat = self.axImageData[indexPath.row].image?.size.width ?? 50
        var fHeight: CGFloat = self.axImageData[indexPath.row].image?.size.height ?? 50
        var fNewHeight: CGFloat = 0.0
        
        let ratio = fWidth / fHeight
        if fWidth > fHeight {
            if fWidth > 300.0 {
                fWidth = 300.0
            }
            fNewHeight = fWidth / ratio
        } else {
            if fHeight > 300.0 {
                fHeight = 300.0
            }
            fNewHeight = fHeight
        }
        return fNewHeight
    }
}
