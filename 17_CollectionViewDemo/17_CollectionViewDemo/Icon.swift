//
//  Icon.swift
//  17_CollectionViewDemo
//
//  Created by 江柏毅 on 2020/12/24.
//

import Foundation


struct Icon {
    
    var name: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, price: Double, isFeatured: Bool) {
        self.name = name
        self.price = price
        self.isFeatured = isFeatured
    }
}
