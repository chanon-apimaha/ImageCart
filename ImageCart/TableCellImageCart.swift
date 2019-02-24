//
//  TableCellImageCart.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 23/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit
import BNImagePageView

class TableCellImageCart: UITableViewCell {
    static let ReuseIdentifier = "TableCellImageCart"
    private var fConWidthImageView: NSLayoutConstraint!
    
    lazy var mImageView: UIImageView = {
        let mImageView: UIImageView = UIImageView()
        mImageView.addTargetClosure(closure: { (mView) in
            if let mImageView = mView as? UIImageView {
            self.ViewImage(imageView: mImageView)
            }
        })
        return mImageView
    }()
    
    lazy var mMainView: UIView = {
        let mMainView: UIView = UIView()
        mMainView.backgroundColor = .clear
        
        let mMainImageView: UIView = {
            let mMainImageView: UIView = UIView()
            self.mImageView.translatesAutoresizingMaskIntoConstraints = false
            mMainImageView.addSubview(self.mImageView)
            self.mImageView.topAnchor.constraint(equalTo: mMainImageView.topAnchor).isActive = true
            self.mImageView.bottomAnchor.constraint(equalTo: mMainImageView.bottomAnchor).isActive = true
            self.mImageView.centerYAnchor.constraint(equalTo: mMainImageView.centerYAnchor).isActive = true
            self.mImageView.centerXAnchor.constraint(equalTo: mMainImageView.centerXAnchor).isActive = true
            self.fConWidthImageView = self.mImageView.widthAnchor.constraint(equalToConstant: 32.0)
            self.fConWidthImageView.isActive = true
            return mMainImageView
        }()
        
        let mRemoveButton: UIButton = UIButton()
        mRemoveButton.addTarget(self, action: #selector(self.removeImage), for: .touchUpInside)
        mRemoveButton.setImage(UIImage(named: "remove"), for: .normal)
        
        mMainImageView.translatesAutoresizingMaskIntoConstraints = false
        mRemoveButton.translatesAutoresizingMaskIntoConstraints = false
        
        mMainView.addSubview(mMainImageView)
        mMainView.addSubview(mRemoveButton)
        
        mMainImageView.leftAnchor.constraint(equalTo: mMainView.leftAnchor, constant: 16.0).isActive = true
        mMainImageView.rightAnchor.constraint(equalTo: mRemoveButton.leftAnchor, constant: -8.0).isActive = true
        mMainImageView.topAnchor.constraint(equalTo: mMainView.topAnchor, constant: 8.0).isActive = true
        mMainImageView.bottomAnchor.constraint(equalTo: mMainView.bottomAnchor, constant: -8.0).isActive = true
        
        mRemoveButton.centerYAnchor.constraint(equalTo: mMainImageView.centerYAnchor).isActive = true
        mRemoveButton.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
        mRemoveButton.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        mRemoveButton.rightAnchor.constraint(equalTo: mMainView.rightAnchor, constant: -16.0).isActive = true
        return mMainView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.mMainView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.mMainView)
        self.contentView.bringSubviewToFront(self.mMainView)
        self.contentView.leftAnchor.constraint(equalTo: self.mMainView.leftAnchor, constant: 0.0).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.mMainView.rightAnchor, constant: 0.0).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.mMainView.topAnchor, constant: 0.0).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.mMainView.bottomAnchor, constant: 0.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configre(ImageData: ImageData?) {
        self.mImageView.backgroundColor = ImageData?.backgroundColor
        self.mImageView.image = ImageData?.image
        var fWidth: CGFloat = ImageData?.image?.size.width ?? 50
        var fHeight: CGFloat = ImageData?.image?.size.height ?? 50
        var fNewWidth: CGFloat = 0.0
        
        let ratio = fWidth / fHeight
        if fWidth < fHeight {
            if fHeight > 300.0 {
                fHeight = 300.0
            }
            fNewWidth = fHeight * ratio
        } else {
            if fWidth > 300.0 {
                fWidth = 300.0
            }
            fNewWidth = fWidth
        }
        
        self.fConWidthImageView.constant = fNewWidth
    }
    
    @objc func removeImage() {
        let alertController = UIAlertController(title: "ต้องการลบรูปภาพ", message:
            "เมื่อลบรูปภาพแล้วจะไม่สามารถดูภาพนี้ได้อีกต่อไป", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "ยืนยัน", style: .destructive,handler: { action in
            self.confirmRemove()
        }))
        
        DispatchQueue.main.async {
            self.contentView.superview?.viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func confirmRemove() {
        if let oTableImageCartController = self.contentView.superview?.viewController as? TableImageCartController {
            oTableImageCartController.axImageData.remove(at: (self.indexPath?.row)!)
            oTableImageCartController.mTableView.beginUpdates()
            oTableImageCartController.mTableView.deleteRows(at: [self.indexPath!], with: .fade)
            oTableImageCartController.mTableView.endUpdates()
        }
    }
    
    func ViewImage(imageView: UIImageView)  {
        if let oTableImageCartController = self.contentView.superview?.viewController as? TableImageCartController {
            oTableImageCartController.navigationController?.BNImagePage(mImageViewShowFirst: imageView, sImageUrl: "")
        }
    }
}
