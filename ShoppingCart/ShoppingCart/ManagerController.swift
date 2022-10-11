//
//  ManagerController.swift
//  ShoppingCart
//
//  Created by Spencer Kinsey-Korzym on 3/3/22.
//

import UIKit

class ManagerController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryAddBtn: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemDesc: UITextView!
    @IBOutlet weak var itemAddBtn: UIButton!
    @IBOutlet weak var itemPrice: UITextField!{
        didSet { itemPrice?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var itemCategoryName: UITextField!
    var navBarName = ""
    private var currentImg: UIImageView? = nil
    private var origininalImage: UIImage = UIImage(systemName: "plus.square")!
    var categories: [CategoryItem] = []
    var categoryItem: [(categoryName: String, items: [ShoppingItem])] = []
    var activeTextField : UITextField? = nil
    var isTextField = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navBarName
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.backgroundColor = .white
        self.categoryName.delegate = self
        self.itemCategoryName.delegate = self
        self.itemName.delegate = self
        self.itemDesc.delegate = self
        self.itemPrice.delegate = self
        itemDesc.textColor = UIColor.lightGray
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(ManagerController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(ManagerController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func didTapUIImageView(_ sender: UITapGestureRecognizer){
        currentImg = sender.view as? UIImageView
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        currentImg!.image = image
        currentImg!.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addCategory(_ sender: Any) {
        let  alertController: UIAlertController = UIAlertController(title: "Error", message: "You need to add an image", preferredStyle: .alert)
        var alertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        if( categoryImage.image! == origininalImage || categoryName.text == ""){
            if(categoryImage.image! == origininalImage){
                alertController.message = "You need to add an image for the category"
                
            }
            else{
                alertController.message = "You need to add a name for the category"
                
            }
        }else{
            categories.append(CategoryItem(image: categoryImage.image!, label: (categoryName.text!)))
            categoryItem.append((categoryName: categoryName.text!, items: []))
            alertController.title = "Success"
            alertController.message = "\(categoryName.text!) has been added!"
            alertAction = UIAlertAction(title: "Done", style: .default, handler: {action in
                self.categoryName.text = ""
                self.categoryImage.image = self.origininalImage
            })
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    @IBAction func addItemAction(_ sender: Any) {
        let  alertController: UIAlertController = UIAlertController(title: "Error", message: "You need to add an image", preferredStyle: .alert)
        var alertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        if(!categoryItem.contains(where: { $0.categoryName == self.itemCategoryName.text})){
            alertController.message = "This category does not exist"
        }else if( itemImage.image! == origininalImage || itemName.text == "" || itemDesc.text == "" || itemPrice.text == ""){
            if(itemImage.image! == origininalImage){
                alertController.message = "You need to add an image for the item"
                
            }else if(itemName.text == ""){
                alertController.message = "You need to add a name for the item"
                
            }else if(itemDesc.text == ""){
                alertController.message = "You need to add a description for the item"
                
            }else if(itemPrice.text == ""){
                alertController.message = "You need to add a price for the item"
            }
        }else{
            let categoryIndex = findCategoryIndex(with: itemCategoryName.text!)
            
            categoryItem[categoryIndex].items.append(ShoppingItem(image: itemImage.image, name: itemName.text!, desc: itemDesc.text!, price: "$\(itemPrice.text!)"))
            alertController.title = "Success"
            alertController.message = "\(itemName.text!.uppercased()) has been added!"
            alertAction = UIAlertAction(title: "Done", style: .default, handler: {action in
                self.itemCategoryName.text = ""
                self.itemName.text = ""
                self.itemImage.image = self.origininalImage
                self.itemDesc.text = "Enter Description"
                self.itemDesc.textColor = .lightGray
                self.itemPrice.text = ""
            })
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func findCategoryIndex( with categoryName: String)-> Int{
        return categoryItem.firstIndex(where: { $0.categoryName == categoryName})!
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black

        }
    }


    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if textView.text.isEmpty {
                textView.text = "Enter Description"
                textView.textColor = UIColor.lightGray
               
            }
            self.view.frame.origin.y = 0
            textView.resignFirstResponder()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // when user select a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        self.activeTextField = textField
        isTextField = true
    }
    
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
        isTextField = false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        var shouldMoveViewUp = false

          // if active text field is not nil
          if let activeTextField = activeTextField {
             
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
              shouldMoveViewUp = true
            }
          }

          if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
          }
        if(!isTextField){
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height
        }
        }
    }
        

    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            let parentVC = self.navigationController?.viewControllers[0] as! ViewController
            (categories.contains(where: { $0.label == categoryName.text!})) ? () : parentVC.cellArray.insert(contentsOf: categories, at: parentVC.cellArray.count-3)
            parentVC.categoryItems = self.categoryItem
            parentVC.myCollectionView.reloadData()
            
        }
    }
}
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
