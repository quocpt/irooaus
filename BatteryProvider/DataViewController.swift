//
//  DataViewController.swift
//  BatteryProvider
//
//  Created by Macbook on 11/6/17.
//  Copyright © 2017 BQAK. All rights reserved.
//

import UIKit
class DataViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var uniqueBrands = [String]()
    var selectedBrand: String = ""
    @IBOutlet weak var brand_picker: UIPickerView!
    
    @IBAction func select_button_press(_ sender: Any) {
        selectedBrand = uniqueBrands[brand_picker.selectedRow(inComponent: 0)]
        let myVC = storyboard?.instantiateViewController(withIdentifier: "CarModelController") as! CarModelController
        myVC.stringPassed = self.selectedBrand
        //myVC.brandSelected_label.text = self.selectedBrand
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        self.title = "SELECT CAR BRAND"
        super.viewDidLoad()
        brand_picker.dataSource = self as! UIPickerViewDataSource
        brand_picker.delegate = self as! UIPickerViewDelegate
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
                    myArray.append(((dict1["Brand"]))!)
                    
                }
                uniqueBrands = myArray.removeDuplicates()
                //print (uniqueBrands)
            
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
        if pickerView == brand_picker {
            return uniqueBrands.count
        }
        else {return 0}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == brand_picker {
            selectedBrand = uniqueBrands[row]
            return uniqueBrands[row]
        }
        
        else {
            selectedBrand = ""
            return ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel?.text = dataObject
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

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
