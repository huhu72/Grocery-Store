//
//  ShoppingCart.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 3/1/22.
//

import UIKit

class ShoppingCartController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var empty: UIButton!
    var navBarName: String = ""
    var cart: [Categories] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        self.myTableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0);
        self.navigationController?.delegate = self
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationItem.title = navBarName
        quantity.text = (cart.isEmpty) ? "0" : getQuantity()
        total.text = (cart.isEmpty) ? "$0" : getTotal()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15))
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 6.5, width: headerView.frame.width-15, height: 15))
        headerLabel.text = cart[section].category
        headerView.backgroundColor = hexStringToUIColor(hex: "#E2E2E2")
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart[section].items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart", for: indexPath) as! ShoppingCartCell
        cell.configure(with: cart[indexPath.section].items[indexPath.row])
        cell.addButtonAction = { [ unowned self ] in
            let item = cart[indexPath.section].items[indexPath.row]
            item.count! += 1
            var price = item.price!
            price.remove(at: price.startIndex)
            cell.itemSubtotal.text =  String("$\(Double(round(100*Double(item.count!) * Double(price)!)/100))")
            cell.itemQuantity.text = String(item.count!)
            quantity.text = getQuantity()
            total.text = getTotal()
        }
        cell.subtractButtonAction = { [ unowned self ] in
            let item = cart[indexPath.section].items[indexPath.row]
            item.count! -= 1
            var price = item.price!
            price.remove(at: price.startIndex)
            cell.itemSubtotal.text =  String("$\(Double(round(100*Double(item.count!) * Double(price)!)/100))")
            cell.itemQuantity.text = String(item.count!)
            if(item.count == 0){
                cart[indexPath.section].items.remove(at: cart[indexPath.section].items.firstIndex(of: item)!)
                let alertController = UIAlertController(title: "ALERT", message: "\(item.name!) deleted", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .cancel){ action in
                    if( cart[indexPath.section].items.isEmpty){
                        cart.remove(at: indexPath.section)
                    }
                    self.myTableView.reloadData()
                }
                alertController.addAction(alertAction)
                present(alertController, animated: true)
                
            }
            //            if( cart[indexPath.section].items.isEmpty){
            //                cart.remove(at: indexPath.section)
            //                self.myTableView.reloadData()
            //            }
            quantity.text = getQuantity()
            total.text = getTotal()
        }
        return cell
    }
    
    func getQuantity() -> String{
        var totalQ = 0
        for category in 0 ..< cart.count{
            for item in 0 ..< cart[category].items.count{
                totalQ += cart[category].items[item].count!
            }
        }
        return String(totalQ)
    }
    func getTotal() -> String{
        var total:Double = 0
        for category in 0 ..< cart.count{
            for item in 0 ..< cart[category].items.count{
                var price = cart[category].items[item].price!
                let count = cart[category].items[item].count!
                price.remove(at: price.startIndex)
                let subtotal = Double(round(100*Double(count) * Double(price)!)/100)
                total += subtotal
            }
        }
        return String("$\(total)")
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func emptyBtnAction(_ sender: Any) {
        cart.removeAll()
        quantity.text = getQuantity()
        total.text = getTotal()
        self.myTableView.reloadData()
    }
    @IBAction func buyBtnAction(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "PAYMENT", message: "Your card will be charged \(total.text!)", preferredStyle: .alert)
        let placeOrderAction = UIAlertAction(title: "Place Order", style: .default) { action in
            self.placeOrderBTNAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(placeOrderAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    func placeOrderBTNAction(){
       performSegue(withIdentifier: "placeOrderHome", sender: self)
        self.emptyBtnAction(self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "placeOrderHome"{
            let destinationVC = segue.destination as! ViewController
            destinationVC.cart = []
            navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#E2E2E2")
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.timeZone = .current
            formatter.locale = .current
            formatter.dateFormat = "MMM/d, EEE, h:mm a"
            let date = formatter.string(from: currentDate)
            (destinationVC.recentOrders.count <= 11) ?  destinationVC.recentOrders.append(RecentOrders(date, quantity.text, total.text)) : ()
           
        }
        if segue.identifier == "home"{
            let destinationVC = segue.destination as! ViewController
            destinationVC.cart = self.cart
        
        }
        
    }
    //handles sending data back to the previous screen when the back button is clicked
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let parentVC = viewController as? TabelViewController
        parentVC?.cart = self.cart
        parentVC?.updateShoppingCartCount()
    }
    @IBAction func goHome(_ sender: Any) {
        performSegue(withIdentifier: "home", sender: self)
    }

}
