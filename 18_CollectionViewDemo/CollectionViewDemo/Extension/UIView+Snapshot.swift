//
//  UIView+Snapshot.swift
//  CollectionViewDemo
//
//  Created by 江柏毅 on 2021/1/4.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit


extension UIView {
    
    var snapshot: UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
            
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
