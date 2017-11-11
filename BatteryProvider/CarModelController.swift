//
//  CarModelController
//  BatteryProvider
//
//  Created by Macbook on 11/6/17.
//  Copyright © 2017 BQAK. All rights reserved.
//

import UIKit
class CarModelController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var brand_selected_label: UILabel?
    @IBOutlet weak var model_picker: UIPickerView!
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var stringPassed = "123"
    var uniqueModels = [String]()
    var selectedModel = ""
    @IBOutlet weak var select_button_pressed: UIButton!
    
    @IBAction func button_pressed(_ sender: Any) {
        selectedModel = uniqueModels[model_picker.selectedRow(inComponent: 0)]
        let myVC = storyboard?.instantiateViewController(withIdentifier: "CarVersionController") as! CarVersionController
        myVC.brandPassed = self.stringPassed
        myVC.modelPassed = selectedModel
        //myVC.brandSelected_label.text = self.selectedBrand
        navigationController?.pushViewController(myVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "SELECT CAR MODEL"
        //print(stringPassed)
        brand_selected_label?.text = stringPassed
        model_picker.dataSource = self as! UIPickerViewDataSource
        model_picker.delegate = self as! UIPickerViewDelegate
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
                if (dict1["Brand"]!==stringPassed)
                {
                    myArray.append(dict1["Model"]!)
                }
                
            }
            uniqueModels = myArray.removeDuplicates()
            print (uniqueModels)
            
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
        if pickerView == model_picker {
            return uniqueModels.count
        }
        else {return 0}
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print(uniqueModels[row])
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == model_picker {
            
            //selectedModel = uniqueModels[model_picker.selectedRow(inComponent: 0)]

            //print(selectedModel)
            return uniqueModels[row]
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



