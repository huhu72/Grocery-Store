//
//  Categories.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 3/1/22.
//

import UIKit

class Categories{
    var category: String
    var items: [ShoppingItem] = []
    
    init(_ category: String, _ itemArray: ShoppingItem){
        self.category = category
        self.items.append(itemArray)
    }
    

    

}
