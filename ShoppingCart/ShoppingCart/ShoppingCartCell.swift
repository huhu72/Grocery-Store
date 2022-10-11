//
//  ShoppingCartCell.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 3/1/22.
//

import UIKit

class ShoppingCartCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSubtotal: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var subtract: UIButton!
    var addButtonAction: () -> () = {}
    var subtractButtonAction: () -> () = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(with item: ShoppingItem){
        var price = item.price!
        price.remove(at: price.startIndex)
        itemName.text = item.name
        itemSubtotal.text = String("$\(Double(round(100*Double(item.count!) * Double(price)!)/100))")
        itemQuantity.text = String(item.count!)

    }
    @IBAction func subButtonTapped(_ sender: UIButton){
       subtractButtonAction()
     }
    @IBAction func addButtonTapped(_ sender: UIButton){
       addButtonAction()
     }
}
struct ShoppingCartItem{
    var name:String
    var subtotal:Double
    var quantity:Int
    
    init(name: String, subtotal: Double, quantity: Int){
        self.name = name
        self.subtotal = subtotal
        self.quantity = quantity
    }
}
