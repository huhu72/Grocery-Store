//
//  TableViewController.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 2/22/22.
//

import UIKit

class TabelViewController: UITableViewController, UINavigationControllerDelegate {
    var navBarName = ""
    var cart: [Categories] = []
    var itemsArray: [ShoppingItem] = []
    var cartLabel: UILabel = UILabel()
    @IBOutlet weak var cartBtnContainer: UIBarButtonItem!
    @IBOutlet weak var cartBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navBarName
        self.tableView.backgroundColor = hexStringToUIColor(hex: "#E2E2E2")
        //Lets you throw data back to home
        self.navigationController?.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        cartLabel = UILabel()
        cartLabel.text = "0"
        cartLabel.center = cartBtn.convert(cartBtn.center, from: cartLabel)
        cartLabel.frame.size = CGSize(width: 23, height: 20)
        cartLabel.textAlignment = .center
        cartBtn.addSubview(cartLabel)
        cartLabel.frame.origin.y -= 15
        cartLabel.frame.origin.x -= 10
        
        (itemsArray.isEmpty) ? nil : updateShoppingCartCount()
        if(!itemsArray.isEmpty){
            updateShoppingCartCount()
        }
            
        //cartLabel.center = cartBtn.center

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArray.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingItemCell
        cell.configure(with: itemsArray[indexPath.item])
       // print("\(cell.name.text!) i")
        cell.addButtonAction = { [unowned self] in
            //print(cell.name.text!)
            //Will check to see if this category exists in the cart
            if(self.cart.contains(where: { $0.category == navBarName})){
                //Saves the index of where this category is in the array
                //since its gonna be used again so that a different item can
                //be put in that categories array
                let i: Int! = self.cart.firstIndex { $0.category == navBarName}
                //Checks to see if an item exists in that categories array
                if(self.cart[i].items.contains(where: { $0.name == cell.name.text})){
                    //Gets the index of the item in that categories array
                    let indexOfCell = cart[i].items.firstIndex(of: cell.shoppingItem)
                    cart[i].items[indexOfCell!].count!+=1
                    cell.shoppingItem.count = cart[i].items[indexOfCell!].count
//                    for cat in cart{
//                        print(cat.category)
//                        for item in cart[0].items{
//                            print("\(item.name!): \(item.count!)")
//                        }
//                    }
                //If the category of this item exists but the item isnt in the
                //array yet, it will add it in
                }else{
                    cell.shoppingItem.count = 1
                    cart[i].items.append(cell.shoppingItem)
//                    print("-----------------Item not added in category--------------")
//                    print("Item Name: \(cell.name.text!)")
//                    print("Count: \(cell.shoppingItem.count!)")
//                    print("-----------------Item not added in category--------------")

                }
            //The category doesnt exist yet
            }else{
                cell.shoppingItem.count = 1
                cart.append(Categories(navBarName, cell.shoppingItem))
//                print("-----------------Item not added--------------")
//                print("Item Name: \(cell.name.text!)")
//                print("Count: \(cell.count)")
//                print("-----------------Item not added--------------")
            }
            
//            if(self.cart.contains(where: { $0.name.text == cell.name.text})){
//                cart[cart.firstIndex(of: cell)!].count+=1
//                cell.count = cart[cart.firstIndex(of: cell)!].count
//            }else{
//                cell.count = 1
//                cart.append(cell)
//            }
            updateItemsArray(cell.shoppingItem)
            updateShoppingCartCount()

        }

        return cell
    }
    func updateItemsArray(_ item: ShoppingItem){
        let indexOfItem = itemsArray.firstIndex(where: {$0.name == item.name})
        itemsArray[indexOfItem!] = item
    }
    func updateShoppingCartCount(){
       var count = 0
        for i in 0..<cart.count{
            for item in cart[i].items{
                count += item.count!
            }
        }
        cartLabel.text = String(count)
//        for item in cart{
//            count += item.count
//
//        }
//        cartLabel.text = String(count)
//        print("Name: \(cart[0].name.text!) Count: \(count)")
//        print(count)

        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cart"{
            let destinationVC = segue.destination as! ShoppingCartController
            let backItem = UIBarButtonItem()
            backItem.title = navBarName
            navigationItem.backBarButtonItem = backItem
            destinationVC.navBarName = "Your Cart"
            destinationVC.cart = self.cart
        }
        
    }
    @IBAction func gotoCart(_ sender: Any) {
        performSegue(withIdentifier: "cart", sender: sender)
    }
    //sends the data to the VC that called this view controller
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
           let parentVC = self.navigationController?.viewControllers[0] as! ViewController
           
            let indexOfCategory = parentVC.categoryItems.firstIndex(where: { $0.categoryName == navBarName})
            parentVC.cart = self.cart
            print("cart when pressed back: \(cart)")
            parentVC.categoryItems[indexOfCategory!].items = itemsArray
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#E2E2E2")
    }

   

}
   
