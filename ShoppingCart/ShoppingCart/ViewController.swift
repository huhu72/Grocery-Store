//
//  ViewController.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 2/22/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var test = ""
    var cellArray: [CategoryItem] =
    [CategoryItem(image: UIImage(named: "groceries")!, label: "Groceries"),
     CategoryItem(image: UIImage(named: "clothes")!, label: "Clothes"),
     CategoryItem(image: UIImage(named: "movies")!, label: "Movies"),
     CategoryItem(image: UIImage(named: "gardens")!, label: "Garden"),
     CategoryItem(image: UIImage(named: "electronics")!, label: "Electronics"),
     CategoryItem(image: UIImage(named: "books")!, label: "Books"),
     CategoryItem(image: UIImage(named: "appliances")!, label: "Appliances"),
     CategoryItem(image: UIImage(named: "toys")!, label: "Toys"),
     CategoryItem(image: UIImage(named: "recent")!, label: "Recent Orders"),
    CategoryItem(image: UIImage(named: "cart")!, label: "Shopping Cart"),
    CategoryItem(image: UIImage(named: "editing")!, label: "Manager")]
    var cart: [Categories] = []
    var recentOrders:[RecentOrders] = []
    var categoryItems: [(categoryName: String, items: [ShoppingItem])] = [
        (categoryName: "Groceries", items: [
            ShoppingItem(image: UIImage(named: "tomato")!, name: "Tomatoes", desc: "On the vine", price: "$2.99", count: 0),
            ShoppingItem(image: UIImage(named: "banana")!, name: "Bananas", desc: "Delicious and Ripe", price: "$1.99", count: 0),
            ShoppingItem(image: UIImage(named: "eggs")!, name: "Eggs", desc: "One Dozen Grade A Eggs", price: "$3.99", count: 0),
            ShoppingItem(image: UIImage(named: "milk")!, name: "Milk", desc: "1 Gallon Whole Milk", price: "$4.99", count: 0),
            ShoppingItem(image: UIImage(named: "apple")!, name: "Apples", desc: "Delicous Red Sweet Apples", price: "$1.99", count: 0)]),
        (categoryName: "Clothes", items: [
            ShoppingItem(image: UIImage(named: "tshirt")!, name: "T-Shirt", desc: "Bring a fresh twist to your daily look with the new lighting T-Shirt.", price: "$2.99", count: 0),
            ShoppingItem(image: UIImage(named: "shorts")!, name: "Shorts", desc: "They are basic and comfy, and all that you need for an easy day.", price: "$15.99", count: 0),
            ShoppingItem(image: UIImage(named: "sweatshirt")!, name: "Sweatshirt", desc: "When the temp drops during the next game, slip on the Mini C Reverse Weave Pullover Hoodie to keep warm.", price: "$45.95", count: 0),
            ShoppingItem(image: UIImage(named: "sneakers")!, name: "Sneakers", desc: " These shoes boast durable canvas uppers, metal eyelets on the sides for ventilation, and rubber outsoles for added traction.", price: "$100.00", count: 0),
            ShoppingItem(image: UIImage(named: "necklace")!, name: "Gold Necklace", desc: "Stand out from the crowd this season with the statement-making Gold Chain Necklace. This classic chain necklace is complete with a sleek gold finish.", price: "$150.00", count: 0),
            ShoppingItem(image: UIImage(named: "earrings")!, name: "Diamond Earrings", desc: "Beautifully matched, these diamond stud earrings feature a pair of round, near-colorless diamonds set in 14k white gold four-prong settings with double-notched friction backs.", price: "$50.99", count: 0)]),
        
        (categoryName: "Movies", items: [
            ShoppingItem(image: UIImage(named: "batman")!, name: "Batman", desc: "Batman ventures into Gotham City's underworld when a sadistic killer leaves behind a trail of cryptic clues.", price: "$2.99", count: 0),
            ShoppingItem(image: UIImage(named: "deadpool")!, name: "Deadpool", desc: "Wade Wilson is a former Special Forces operative who now works as a mercenary. His world comes crashing down when evil scientist Ajax (transforms him into Deadpool. ", price: "$1.99", count: 0),
            ShoppingItem(image: UIImage(named: "ironman")!, name: "Iron Man", desc: "A billionaire industrialist and genius inventor, Tony Stark, is conducting weapons tests overseas, but terrorists kidnap him to force him to build a devastating weapon.", price: "$3.99", count: 0),
            ShoppingItem(image: UIImage(named: "spiderman")!, name: "Spiderman", desc: "Spider-Man centers on student Peter Parker  who, after being bitten by a genetically-altered spider, gains superhuman strength and the spider-like ability to cling to any surface.", price: "$4.99", count: 0),
            ShoppingItem(image: UIImage(named: "superman")!, name: "Superman", desc: " Raised by kindly farmers Jonathan and Martha Kent, young Clark discovers the source of his superhuman powers and moves to Metropolis to fight evil. ", price: "$1.99", count: 0)]),
        
        (categoryName: "Garden", items: [
            ShoppingItem(image: UIImage(named: "fern")!, name: "Fern", desc: "The tall strappy leaf plant requires minimal care and adds instant beauty to your home or office", price: "$20.99", count: 0),
            ShoppingItem(image: UIImage(named: "pruner")!, name: "Pruner", desc: "The tall strappy leaf plant requires minimal care and adds instant beauty to your home or office", price: "$11.99", count: 0),
            ShoppingItem(image: UIImage(named: "rake")!, name: "Rake", desc: "Lightweight and durable poly head. Smooth wood handle for easy use. Perfect for the general leaf raking and clean up task", price: "$12.98", count: 0),
            ShoppingItem(image: UIImage(named: "shovel")!, name: "Shovel", desc: "Digging shovel with wood handle is ideal for digging a variety of holes. Durable tempered steel, round point blade features a secure step allows for solid placement for added digging force", price: "$21.99", count: 0),
            ShoppingItem(image: UIImage(named: "wheel")!, name: "Wheel Barrel", desc: "5.5cf steel tray for both the homeowner and professional user. Solid hardwood shaped handles for strength and a comfortable grip. Front tray braces for maximum support", price: "$129.99", count: 0)]),
        
        (categoryName: "Electronics", items: [
            ShoppingItem(image: UIImage(named: "computer")!, name: "iMac", desc: "Inspired by the best of Apple. Transformed by the M1 chip. Stands out in any space. Fits perfectly into your life.", price: "$2000.99", count: 0),
            ShoppingItem(image: UIImage(named: "card")!, name: "Nvidia 3080 Graphics Card", desc: "The GeForce RTX™ 3080 Ti and RTX 3080 graphics cards deliver the ultra performance that gamers crave, powered by Ampere—NVIDIA’s 2nd gen RTX architecture.", price: "$129.99", count: 0),
            ShoppingItem(image: UIImage(named: "headphones")!, name: "Headphones", desc: " The 3.9ft durable wired earbuds provide you a comfortable wearing experience for gaming, hiking or jogging, etc.", price: "$30.99", count: 0),
            ShoppingItem(image: UIImage(named: "iphone")!, name: "iPhone 13 Pro Max", desc: "A dramatically more powerful camera system. A display so responsive, every interaction feels new again. The world’s fastest smartphone chip. Exceptional durability. Let’s Pro.", price: "$1000.99", count: 0),
            ShoppingItem(image: UIImage(named: "tv")!, name: "Samsung Smart TV", desc: " Boasting native 4K resolution and advanced HDR technology, this Samsung smart TV enriches your movie nights with stunningly detailed visuals and lifelike colors.", price: "$5000.00", count: 0)]),
        
        (categoryName: "Books", items: [
            ShoppingItem(image: UIImage(named: "kid")!, name: "Kids ABC Book", desc: "Teach your kids the alphabet the easy way", price: "$2.99", count: 0),
            ShoppingItem(image: UIImage(named: "mystery")!, name: "Mystery", desc: "Dig in this murder mystery book to bypass time", price: "$1.99", count: 0),
            ShoppingItem(image: UIImage(named: "romance")!, name: "Romance", desc: "Perfect for those that are suckers for a great romance story", price: "$3.99", count: 0),
            ShoppingItem(image: UIImage(named: "scary")!, name: "Scary", desc: "Make sure you're not alone while reading this because it will for sure give you the chills", price: "$4.99", count: 0),
            ShoppingItem(image: UIImage(named: "textbook")!, name: "CMSC 428 Textbook", desc: "Ace the class with this super in depth textbook starting from basic swift topics up to mastering the storyboard in Xcode", price: "$119.99", count: 0)]),
        
        (categoryName: "Appliances", items: [
            ShoppingItem(image: UIImage(named: "coffee")!, name: "Coffee Machine", desc: "Start your day with a fresh cup of morning joe with this 5-cup Mr. Coffee programmable coffeemaker.", price: "$21.99", count: 0),
            ShoppingItem(image: UIImage(named: "dishwasher")!, name: "Dishwasher", desc: "Dual Power filtration filters out then disintegrates food. PowerBlast® cycle scours away stubborn foods. Heated Dry ups temperatures to get dishes nice and dry", price: "$599.99", count: 0),
            ShoppingItem(image: UIImage(named: "fridge")!, name: "Fridge", desc: "With a 20.5 cu ft Frigidaire top freezer refrigerator, you can have a refrigerator that fits the same space as an 18 cu ft top freezer refrigerator, but get more capacity. ", price: "$749.99", count: 0),
            ShoppingItem(image: UIImage(named: "microwave")!, name: "Microwave", desc: "Our microwave with a turntable accommodates various dish sizes while microwave presets deliver the right amount of time and heat.", price: "$40.99", count: 0),
            ShoppingItem(image: UIImage(named: "toaster")!, name: "Toaster", desc: "his toaster does it all for you. Just pick your toast shade once and no matter what type of bread you toast, you'll get consistent browning.", price: "$12.99", count: 0)]),
        
        (categoryName: "Toys", items: [
            ShoppingItem(image: UIImage(named: "duck")!, name: "Rubber Ducky", desc: "PERFECT FIDGET TOY during classes, meetings and long phone calls. DURABLE, NON-TOXIC MATERIALS mean parents, teachers and guardians can rest easy while letting their children play.", price: "$2.99", count: 0),
            ShoppingItem(image: UIImage(named: "horse")!, name: "Rocking Horse", desc: "This kids rocking horse combines a traditional plush horse design with modern features like simulated neighing and galloping sounds.", price: "$50.99", count: 0),
            ShoppingItem(image: UIImage(named: "kite")!, name: "Kite", desc: "Deadly Easy to Fly. This is a classic triangle kite with bright colors, beginner can handle it well without any problem. All ready to go to fly.", price: "$21.99", count: 0),
            ShoppingItem(image: UIImage(named: "robot")!, name: "Robot", desc: "The infrared control Robot is versatile and vivid can dance,sing,walk,patrol,even can speak with a charming accent.", price: "$169.99", count: 0),
            ShoppingItem(image: UIImage(named: "toy-train")!, name: "Toy Train", desc: "The exquisite colorful packaging is perfect for as a gift-giving every child.", price: "$180.00", count: 0)])
    ]
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        let navController = navigationController!
        let logo = UIImage(named: "t")
        let imageView = UIImageView(image: logo)
        let imageWidth = navController.navigationBar.frame.size.width
        let imageHeight = navController.navigationBar.frame.size.height
        let imageX = imageWidth / 2 - (logo?.size.width)! / 2
        let imageY = imageHeight / 2 - (logo?.size.height)! / 2
        imageView.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#E2E2E2")
     
    }
        
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "prototypeCell", for: indexPath) as! CategoryItemCell
        cell.configure(with: cellArray[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 125, height: 125)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = sender as! IndexPath
        let backItem = UIBarButtonItem()
            backItem.title = "Home"
            navigationItem.backBarButtonItem = backItem
        if segue.identifier == "category"{
            let destinationVC = segue.destination as! TabelViewController
            switch(selectedIndexPath.item){
            case categoryItems.startIndex..<categoryItems.endIndex :
                destinationVC.navBarName = categoryItems[selectedIndexPath.item].categoryName
            default:
                print()
            }
            destinationVC.itemsArray = categoryItems[selectedIndexPath.item].items
            destinationVC.cart = self.cart
        }
        if segue.identifier == "recentOrder"{
            let destinationVC = segue.destination as! RecentOrdersController
            destinationVC.navBarName = "Recent Orders"
            destinationVC.recentOrders = self.recentOrders
            
        }
        if segue.identifier == "cart"{
            let destinationVC = segue.destination as! ShoppingCartController
            destinationVC.navBarName = "Shopping Cart"
            destinationVC.cart = self.cart
        }
        if segue.identifier == "manager"{
            let destinationVC = segue.destination as! ManagerController
            destinationVC.navBarName = "Manager"
            destinationVC.categoryItem = self.categoryItems
        }
            
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.item){
        case categoryItems.startIndex..<categoryItems.endIndex:
            performSegue(withIdentifier: "category", sender: indexPath)
        case cellArray.endIndex-3:
            performSegue(withIdentifier: "recentOrder", sender: indexPath)
        case cellArray.endIndex-2:
            performSegue(withIdentifier: "cart", sender: indexPath)
        case cellArray.endIndex-1:
            performSegue(withIdentifier: "manager", sender: indexPath)
        default:
            print()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth = 125 * 2
        let totalSpacingWidth = 50

        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    @IBAction func homeClear( _ seg: UIStoryboardSegue) {
        
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
    

}



