//
//  Icon.swift
//  CollectionViewDemo
//
//  Created by Slawek Kurczewski on 09.03.2017.
//  Copyright © 2017 Slawomir Kurczewski. All rights reserved.
//

import Foundation
struct Icon {
    var name: String
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, price:Double, isFeatured:Bool)
    {
        self.name=name
        self.price=price
        self.isFeatured=isFeatured
    }
}
