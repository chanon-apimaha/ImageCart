//
//  ImagePickerManager.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 25/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "เลือกแหล่งรูปภาพ", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    
    override init(){
        super.init()
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        self.pickImageCallback = callback;
        self.viewController = viewController;
        
        let cameraAction = UIAlertAction(title: "ถ่ายรูปภาพจากกล้อง", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "คลังรูปภาพ", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "ยกเลิก", style: .cancel){
            UIAlertAction in
        }
        
        self.picker.delegate = self
        self.alert.addAction(cameraAction)
        self.alert.addAction(gallaryAction)
        self.alert.addAction(cancelAction)
        self.alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present( self.alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        self.alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            self.picker.sourceType = .camera
            self.viewController!.present( self.picker, animated: true, completion: nil)
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI
                let alertController = UIAlertController(title: "ข้อผิดพลาด", message:
                    "ไม่พบกล้องถ่ายภาพ", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "ตกลง", style: .cancel, handler: nil))
                
                DispatchQueue.main.async {
                    self.viewController!.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func openGallery(){
        self.alert.dismiss(animated: true, completion: nil)
        self.picker.sourceType = .photoLibrary
        self.viewController!.present( self.picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.pickImageCallback?(image)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        guard let image = pickedImage else {
            fatalError("Expected a dictionary containing an image")
        }
        self.pickImageCallback?(image)
    }
}

