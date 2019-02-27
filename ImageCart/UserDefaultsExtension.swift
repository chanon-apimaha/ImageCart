//
//  UserDefaultsExtension.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 25/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit

extension UserDefaults {
    //MARK: Save Number Image
    func setNumImage(value: Int) {
        set(value, forKey: "NumImage")
    }
    
    //MARK: Retrieve Number Image
    func getsetNumImage() -> Int {
        return integer(forKey: "NumImage")
    }
}
