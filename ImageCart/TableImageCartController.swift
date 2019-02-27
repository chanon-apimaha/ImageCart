//
//  TableImageCartController.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 22/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit
import Photos

class TableImageCartController: UIViewController {
    
    var axImageData: [ImageData] = [
        //        ImageData(image: UIImage(named: "work"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "think"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "slow"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "sad"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "happy"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "diamond"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "passion"), backgroundColor: .blue),
        //        ImageData(image: UIImage(named: "moterBike"), backgroundColor: .red),
        //        ImageData(image: UIImage(named: "yogurt"), backgroundColor: .green),
        //        ImageData(image: UIImage(named: "food"), backgroundColor: .yellow),
    ]
    
    lazy var mHeaderView: UIView = {
        let mMainView: UIView = UIView()
        mMainView.backgroundColor = UIColor(hex: "#f99325")
        
        let mHoldButton: UIButton = UIButton()
        mHoldButton.setTitle("ล้าง", for: .normal)
        mHoldButton.addTargetClosure(closure: { (mButton) in
           self.clearImageCache()
        })
        let mHeaderLabel: UILabel = UILabel()
        mHeaderLabel.textColor = UIColor(hex: "#f4dfc8")
        mHeaderLabel.text = "คลังรูปภาพของฉัน"
        mHeaderLabel.textAlignment = .center
        
        let mAddImageButton: UIButton = UIButton()
        mAddImageButton.setImage(UIImage(named: "add-image-2"), for: .normal)
        mAddImageButton.addTargetClosure(closure: { (mView) in
            self.checkPermissionPhotoOnDevice()
        })
        
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
        
        self.axImageData = loadImageFromDocument()
        self.mTableView.reloadData()
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
    
    func checkPermissionPhotoOnDevice() {
        let iStatus = PHPhotoLibrary.authorizationStatus()
        switch iStatus {
        case .authorized:
            self.selectPhoto()
        case .denied:
            self.alertPhotoPermission()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (iUnknowStatus) in
                if iUnknowStatus == .authorized {
                    self.selectPhoto()
                } else {
                    self.alertPhotoPermission()
                }
            })
        case .restricted:
            self.alertPhotoPermission()
        }
    }
    
    func alertPhotoPermission() {
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            
            DispatchQueue.main.async {
                self.view.endEditing(true)
                let alertController = UIAlertController(title: "ขออนุญาติเข้าถึงคลังรูปภาพ", message:
                    "แอปพลิเคชัน ImageCart ขออนุญาติเข้าถึงคลังรูปภาพ เพื่อบันทึกรูปภาพ", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: "เปิดตั้งค่า", style: .destructive,handler: { action in
                    let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
                    if let url = settingsUrl as URL? {
                        UIApplication.shared.openURL(url)
                    }
                }))
                
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func selectPhoto() {
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            print(image.size)
            let iNumImage = UserDefaults.standard.getsetNumImage() + 1
            UserDefaults.standard.setNumImage(value: iNumImage)
            self.saveImageToDocuments(image: image, fileNameWithExtension: "\(iNumImage).jpg")
            //self.axImageData = self.loadImageFromDocument()
            
            let aa = IndexPath(row: self.axImageData.count, section: 0)
            self.axImageData.append(ImageData(image: image, name: "\(iNumImage).jpg", backgroundColor: .blue))
            self.mTableView.beginUpdates()
            self.mTableView.insertRows(at: [aa], with: .fade)
            self.mTableView.endUpdates()
             self.mTableView.scrollToRow(at: aa, at: UITableView.ScrollPosition.none, animated: true)
//            self.mTableView.reloadData()
        }
    }
    let fileDirectory : NSURL  = {
        return try! FileManager.default.url(for: .documentDirectory , in: .userDomainMask , appropriateFor: nil, create: true)
        }() as NSURL
    
    func saveImageToDocuments(image: UIImage, fileNameWithExtension: String) {
        
        let imagePath = fileDirectory.appendingPathComponent("\(fileNameWithExtension)")
        
        guard let imageData = image.jpegData(compressionQuality: 1)  else {
            // handle failed conversion
            return
        }
        
        do {
            try imageData.write(to: imagePath!, options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
    }
    
    func removeAllImageFromDocuments() {
        var theItems = [String]()
        let imageURL = fileDirectory
        
        do {
            theItems = try FileManager.default.contentsOfDirectory(atPath: imageURL.path!)
            for fileURL in theItems {
                try FileManager.default.removeItem(at: imageURL.appendingPathComponent("\(fileURL)")!)
            }
            self.axImageData = self.loadImageFromDocument()
            self.mTableView.reloadData()
            UserDefaults.standard.setNumImage(value: 0)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func removeItemImageFromDocument(imageNameExtfile: String)  {
         let imageURL = fileDirectory
        do {
            try FileManager.default.removeItem(at:  imageURL.appendingPathComponent("\(imageNameExtfile)")!)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func loadImageFromDocument() -> [ImageData] {
        var theItems = [String]()
        let imageURL = fileDirectory
        var theItemsImage: [ImageData] = []
        do {
            theItems = try FileManager.default.contentsOfDirectory(atPath: imageURL.path!)
            for fileURL in theItems {
                do {
                    let imageData = try Data(contentsOf: imageURL.appendingPathComponent(fileURL)!)
                    theItemsImage.append(ImageData(image: UIImage(data: imageData)!, name: fileURL, backgroundColor: .blue))
                } catch {
                    print("Error loading image : \(error)")
                }
            }
            return theItemsImage
        } catch let error as NSError {
            print(error.localizedDescription)
            return theItemsImage
        }
    }
    
    func clearImageCache() {
        let alertController = UIAlertController(title: "ต้องการลบรูปภาพทั้งหมด", message:
            "เมื่อลบรูปภาพแล้วจะไม่สามารถดูภาพนี้ได้อีกต่อไป", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "ยืนยัน", style: .destructive,handler: { action in
            self.removeAllImageFromDocuments()
        }))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
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
