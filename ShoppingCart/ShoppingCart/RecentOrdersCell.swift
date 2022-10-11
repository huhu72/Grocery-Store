//
//  RecentOrdersCell.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 3/3/22.
//

import UIKit

class RecentOrdersCell: UITableViewCell {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with order: RecentOrders){
        orderLabel.text = "\(order.orderNumItems!) items (\(order.orderTotal!))"
        orderTime.text = order.orderDate
    }

}
class RecentOrders{
    var orderDate: String
    var orderNumItems: String?
    var orderTotal: String?
    init(_ date: String, _ numItems: String? = nil, _ total: String? = nil){
        self.orderDate = date
        self.orderNumItems = numItems
        self.orderTotal = total
    }
    
}
