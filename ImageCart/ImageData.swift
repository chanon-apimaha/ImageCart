//
//  ImageData.swift
//  ImageCart
//
//  Created by Banchai Nangpang on 24/2/2562 BE.
//  Copyright © 2562 Developer BN. All rights reserved.
//

import UIKit

public class ImageData {
    let image: UIImage?
    let name: String?
    let backgroundColor: UIColor?

    public init(image: UIImage?, name: String, backgroundColor: UIColor?) {
        self.image = image
        self.name = name
        self.backgroundColor = backgroundColor
    }
}
