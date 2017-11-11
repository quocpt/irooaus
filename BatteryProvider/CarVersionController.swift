//
//  CarVersionController.swift
//  BatteryProvider
//
//  Created by Macbook on 11/9/17.
//  Copyright © 2017 BQAK. All rights reserved.
//

import Foundation
//
//  CarVersionController
//  BatteryProvider
//
//  Created by Macbook on 11/6/17.
//  Copyright © 2017 BQAK. All rights reserved.
//

import UIKit
class CarVersionController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var version_picker: UIPickerView!
    @IBOutlet weak var model_label: UILabel?
    @IBOutlet weak var brand_selected_label: UILabel?
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var brandPassed = "123"
    var modelPassed = ""
    var uniqueVersions = [String]()
    var selected_version = ""
    @IBOutlet weak var select_button_pressed: UIButton!
    
    @IBAction func button_pressed(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "CarYearController") as! CarYearController
        myVC.brandPassed = self.brandPassed
        myVC.modelPassed = self.modelPassed
        myVC.versionPassed = self.selected_version
        
         navigationController?.pushViewController(myVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "SELECT CAR VERSION"
        //print(stringPassed)
        brand_selected_label?.text = brandPassed
        model_label?.text = modelPassed
        version_picker.dataSource = self as! UIPickerViewDataSource
        version_picker.delegate = self as! UIPickerViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = Bundle.main.url(forResource: "car", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let dataArray = try PropertyListSerialization.propertyList(from: data, format: nil) as! [[String:String]]
            //let dict = (dataArray)[1]
            //print(dict)
            var myArray = [String]()
            for dict1 in dataArray
            {
                if ((dict1["Brand"]!==brandPassed) && (dict1["Model"]!==modelPassed ))
                {
                    myArray.append(dict1["Version"]!)
                }
                
            }
            uniqueVersions = myArray.removeDuplicates()
            //print (uniqueVersions)
            
        }
        catch {
            print("This error must not happen", error)
        }
        
        //print (getDataFromBrand(brand: "TOYOTA"))
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == version_picker {
            return uniqueVersions.count
        }
        else {return 0}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == version_picker {
            selected_version = uniqueVersions[row]
            return uniqueVersions[row]
        }
            
        else {
            return ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    func getSwiftArrayFromPlist(name: String)->(Array<Dictionary<String,String>>)
    {
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        var arr : NSArray?
        arr = NSArray(contentsOfFile: path!)
        return (arr as? Array<Dictionary<String,String>>)!
    }
    
    func getDataFromBrand(brand:String)->(Array<[String:String]>)
    {
        let array = getSwiftArrayFromPlist(name: "car")
        let namePredicate = NSPredicate(format: "",brand)
        return [array.filter {namePredicate.evaluate(with: $0)}[1]]
        
    }
    
}



