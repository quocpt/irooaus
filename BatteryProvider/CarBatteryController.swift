//
//  CarBatteryController
//  BatteryProvider
//
//  Created by Macbook on 11/9/17.
//  Copyright © 2017 BQAK. All rights reserved.
//
import MessageUI
import Foundation
//
//  CarModelController
//  BatteryProvider
//
//  Created by Macbook on 11/6/17.
//  Copyright © 2017 BQAK. All rights reserved.
//

import UIKit
class CarBatteryController: UIViewController, UITextFieldDelegate,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var better_description_label: UILabel!
    @IBOutlet weak var good_description_label: UILabel!
    @IBOutlet weak var good_price_label: UILabel!
    @IBOutlet weak var better_price_label: UILabel!
    
    @IBOutlet weak var logo_icon: UIImageView!
    @IBOutlet weak var contact_number_textbox: UITextField!
    @IBOutlet weak var better_quantity_textbox: UITextField!
    @IBOutlet weak var good_quantity_textbox: UITextField!
    @IBOutlet weak var better_id_label: UILabel!
    @IBOutlet weak var good_id_label: UILabel!
    @IBOutlet weak var myCell: UIView!
    @IBOutlet weak var battery_table: UITableView!
    @IBOutlet weak var selectionBattery_segment: UISegmentedControl!
    @IBOutlet weak var version_label: UILabel!
    @IBOutlet weak var Good_battery_picker: UIPickerView!
    @IBOutlet weak var year_label: UILabel!
    @IBOutlet weak var model_label: UILabel?
    @IBOutlet weak var brand_selected_label: UILabel?
    @IBOutlet weak var dataLabel: UILabel!
    
    
    var Item1 = ["Item1","Item1","Item1","Item1"]
    var Item2 = ["Item2","Item2","Item2","Item2"]
    
    var good_price = ""
    var better_price = ""
    var dataObject: String = ""
    var brandPassed = "123"
    var modelPassed = ""
    var YearPassed = ""
    var versionPassed = ""
    var uniqueBattery = [String]()
    var uniqueBetterBattery = [String]()
    var batterySelectedModel = ""
    var saveTrack = String()
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func button_pressed(_ sender: Any) {
        saveTrack = (contact_number_textbox.text)!
        saveData()
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["sales@hoco.com.au"])
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date as Date)
        //print(dateString)
        
        composeVC.setSubject("Iroo APP --- Order " + dateString)
        
        var mess = "-Car Brand:" + brandPassed + "\n-Car Model: " + modelPassed + "\n-Car Year: " + YearPassed + "\n-Phone: " + contact_number_textbox.text! + "\n------------------\n-GOOD Model: " + good_id_label.text! + "\n-GOOD Quantity: " + good_quantity_textbox.text! + "\n-BETTER Model: " + better_id_label.text! + "\n-BETTER Quantity: " + better_quantity_textbox.text!
        
        composeVC.setMessageBody( mess, isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    //Touch logo action
    func tappedMe()
    {
        better_price_label.text = better_price + "$"
        good_price_label.text = good_price + "$"
        better_price_label.isHidden = false
        good_price_label.isHidden = false
    }
    
    func populateBatteryInfo()
    {
        
        let url = Bundle.main.url(forResource: "battery", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let dataArray = try PropertyListSerialization.propertyList(from: data, format: nil) as! [[String:String]]
            //let dict = (dataArray)[1]
            //print(dict)
            var myArray = [String]()
            var myArray2 = [String]()
            for dict1 in dataArray
            {
                if (dict1["MODEL"]! == uniqueBattery.joined())
                    {
                        myArray.append(dict1["DESCRIPTION"]!)
                        good_price = dict1["PRICE"]!
                        
                }
                else if  (dict1["MODEL"]! == uniqueBetterBattery.joined())
                {
                    myArray2.append(dict1["DESCRIPTION"]!)
                    better_price = dict1["PRICE"]!
                }
                
            }
            better_description_label.text = myArray2.joined()
            good_description_label.text = myArray.joined()
            
            //print (uniqueBattery)
            
        }
        catch {
            print("This error must not happen", error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logo touch
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
        tap.numberOfTapsRequired = 3

        logo_icon.addGestureRecognizer(tap)
        logo_icon.isUserInteractionEnabled = true
        
         self.title = "SELECT BATTERY MODEL"
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                print(dict["userPhone"] as! String)
            }
        }
        contact_number_textbox.delegate = self as? UITextFieldDelegate
        better_quantity_textbox.delegate = self as? UITextFieldDelegate
        good_quantity_textbox.delegate = (self as! UITextFieldDelegate)
        
        
        //print(stringPassed)
        brand_selected_label?.text = brandPassed
        model_label?.text = modelPassed
        year_label?.text = YearPassed
        version_label?.text = versionPassed
        
        //Good_battery_picker.dataSource = self as! UIPickerViewDataSource
        //Good_battery_picker.delegate = self as! UIPickerViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = Bundle.main.url(forResource: "car", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let dataArray = try PropertyListSerialization.propertyList(from: data, format: nil) as! [[String:String]]
            //let dict = (dataArray)[1]
            //print(dict)
            var myArray = [String]()
            var myArray2 = [String]()
            for dict1 in dataArray
            {
                if ((dict1["Brand"]!==brandPassed) && (dict1["Model"]!==modelPassed ) && (dict1["Version"]!==versionPassed ) && (dict1["Year"]!==YearPassed ))
                {
                    myArray.append(dict1["GOOD"]!)
                    myArray2.append(dict1["BETTER"]!)
                }
                
            }
            uniqueBattery = myArray.removeDuplicates()
            uniqueBetterBattery = myArray2.removeDuplicates()
            //print (uniqueBattery)
            
        }

        
        catch {
            print("This error must not happen", error)
        }
        
        good_id_label?.text = uniqueBattery.joined()
        better_id_label?.text = uniqueBetterBattery.joined()
        better_quantity_textbox?.text = ""
        good_quantity_textbox?.text = ""
        populateBatteryInfo()
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    //save data
    func saveData() {
        var playersDictionaryPath = Bundle.main.path(forResource: "Info", ofType: "plist")
        var playersDictionary = NSMutableDictionary(contentsOfFile: playersDictionaryPath!)
        
        
        var playersNamesArray = playersDictionary?.object(forKey: "userPhone") as! String
        
        //this is a label I have called player1Name
        playersNamesArray = contact_number_textbox.text!
        
        playersDictionary?.write(toFile: playersDictionaryPath!, atomically: true)
    }
    
    
    
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

}




