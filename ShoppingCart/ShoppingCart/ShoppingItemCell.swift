//
//  ShoppingItemCell.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 2/22/22.
//

import UIKit

class ShoppingItemCell: UITableViewCell {

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    var addButtonAction: () -> () = {}
    var shoppingItem: ShoppingItem = ShoppingItem()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(with cell: ShoppingItem){
        cellImage.image = cell.image
        name.text = cell.name
        price.text = cell.price!
        desc.text = cell.desc!
        shoppingItem = cell
    }

    @IBAction func addButtonTapped(_ sender: UIButton){

       addButtonAction()
     }
}
class ShoppingItem: NSObject{
    var image: UIImage?
    var name: String?
    var desc: String?
    var price: String? = "$"
    var count: Int?
    
    init( image: UIImage? = nil, name: String? = nil, desc: String? = nil, price: String? = nil, count: Int? = nil){
        self.image = image
        self.name = name
        self.desc = desc
        self.price = price
        self.count = count
    }
    func updateCount(_ num: Int){
        self.count = num
    }
}
