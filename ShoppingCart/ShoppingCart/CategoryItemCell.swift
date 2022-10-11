//
//  CatagoryCell.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 2/22/22.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!

    public func configure(with cell: CategoryItem) {
           image.image = cell.image
           label.text = cell.label
       }
}
struct CategoryItem{
    var image: UIImage
    var label: String
}
