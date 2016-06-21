//
//  ViewController.swift
//  TaxCalculator
//
//  Created by Arthur Pankiewicz on 2016-01-21.
//  Copyright © 2016 Arthur Pankiewicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var provincePicker: UIPickerView!
    
    @IBOutlet weak var calcButton: UIButton!

    @IBOutlet weak var incomeLabel: UITextView!
    
    @IBOutlet weak var salaryTextField: UITextField!

    @IBOutlet weak var beforeTax: UITextView!
    @IBOutlet weak var provincialTax: UITextView!
    @IBOutlet weak var federalTax: UITextView!
    @IBOutlet weak var afterTax: UITextView!
    
    //Tax rates and brackets for 
    //Alberta
    let abRates             = [Double] (arrayLiteral: 0.1, 0.12, 0.13, 0.14, 0.15)
    let abBrackets          = [Double] (arrayLiteral: 0, 125000, 150000, 200000, 300000)
    //British Colubmia
    let bcRates             = [Double] (arrayLiteral: 0.0506, 0.077, 0.105, 0.1229, 0.147)
    let bcBrackets          = [Double] (arrayLiteral: 0, 38210, 76421, 87741, 106543)
    //Manitoba
    let mbRates             = [Double] (arrayLiteral: 0.108, 0.1275, 0.174)
    let mbBrackets          = [Double] (arrayLiteral: 0, 31000, 67000)
    //New Brunswick
    let nbRates             = [Double] (arrayLiteral: 0.0968, 0.1482, 0.1652, 0.1784, 0.21, 0.2575)
    let nbBrackets          = [Double] (arrayLiteral: 0, 40492, 80985, 131664, 150000, 250000)
    //Newfoundland and Labrador
    let nlRates             = [Double] (arrayLiteral: 0.077, 0.125, 0.133, 0.143, 0.153)
    let nlBrackets          = [Double] (arrayLiteral: 0, 35148, 70295, 125500, 175700)
    //Northwest Territories
    let ntRates             = [Double] (arrayLiteral: 0.059, 0.086, 0.122, 0.1405)
    let ntBrackets          = [Double] (arrayLiteral: 0, 41011, 82024, 133353)
    //Nova Scotia
    let nsRates             = [Double] (arrayLiteral: 0.0879, 0.1495, 0.1667, 0.175, 0.21)
    let nsBrackets          = [Double] (arrayLiteral: 0, 29590, 59180, 93000, 150000)
    //Nunavut
    let nvRates             = [Double] (arrayLiteral: 0.04, 0.07, 0.09, 0.115)
    let nvBrackets          = [Double] (arrayLiteral: 0, 43176, 86351, 140388)
    //Ontario
    let onRates             = [Double] (arrayLiteral: 0.0505, 0.0915, 0.1116, 0.1216, 0.1316)
    let onBrackets          = [Double] (arrayLiteral: 0, 41536, 83075, 150000, 220000)
    //Prince Edward Island
    let peRates             = [Double] (arrayLiteral: 0.098, 0.138, 0.167)
    let peBrackets          = [Double] (arrayLiteral: 0, 31984, 63969)
    //Quebec
    let qcRates             = [Double] (arrayLiteral: 0.16, 0.2, 0.24, 0.2575)
    let qcBrackets          = [Double] (arrayLiteral: 0, 42390, 84780, 103150)
    //Saskatchewan
    let skRates             = [Double] (arrayLiteral: 0.11, 0.13, 0.15)
    let skBrackets          = [Double] (arrayLiteral: 0, 44061, 127430)
    //Yukon
    let ytRates             = [Double] (arrayLiteral: 0.064, 0.09, 0.109, 0.128, 0.15)
    let ytBrackets          = [Double] (arrayLiteral: 0, 45282, 90563, 140388, 500000)
    
    //Federal
    let federalRates        = [Double] (arrayLiteral: 0.15, 0.205, 0.26, 0.29, 0.33)
    let federalBrackets     = [Double] (arrayLiteral: 0, 45282, 90563, 140388, 200000)
    
    let pickerData          = ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador",
                               "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island",
                               "Quebec", "Saskatchewan", "Yukon"]
    
    var provincial: Double  = 0
    var federal: Double     = 0
    var input: Double       = 0;
    
    override func viewDidLoad() {
        numberOnly()
        borders()
        super.viewDidLoad()
        provincePicker.dataSource = self
        provincePicker.delegate = self
    }
    
    
    //Function to initialize the input textfield as number only.
    func numberOnly() {
        beforeTax.text      = "-"
        provincialTax.text  = "-"
        federalTax.text     = "-"
        afterTax.text       = "-"
    }
    
    func borders() {
        calcButton.layer.borderWidth = 1
        calcButton.layer.cornerRadius = 3
        let lightblue = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        calcButton.layer.borderColor = lightblue.CGColor
    }

    @IBAction func calculateButton(sender: UIButton) {
        
        let formatter           = NSNumberFormatter()
        formatter.numberStyle   = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale        = NSLocale(localeIdentifier: "en_CA")
        
        let index = provincePicker.selectedRowInComponent(0)
        
        switch(index) {
        case 0:
            calculate(abBrackets, rates: abRates)   //AB
        case 1:
            calculate(bcBrackets, rates: bcRates)   //BC
        case 2:
            calculate(mbBrackets, rates: mbRates)   //MB
        case 3:
            calculate(nbBrackets, rates: nbRates)   //NB
        case 4:
            calculate(nlBrackets, rates: nlRates)   //NL
        case 5:
            calculate(ntBrackets, rates: ntRates)   //NT
        case 6:
            calculate(nsBrackets, rates: nsRates)   //NS
        case 7:
            calculate(nvBrackets, rates: nvRates)   //NV
        case 8:
            calculate(onBrackets, rates: onRates)   //ON
        case 9:
            calculate(peBrackets, rates: peRates)   //PE
        case 10:
            calculate(qcBrackets, rates: qcRates)   //QC
        case 11:
            calculate(skBrackets, rates: skRates)   //SK
        case 12:
            calculate(ytBrackets, rates: ytRates)   //YT
        default:
            calculate(bcBrackets, rates: bcRates)   //default
        }

        self.view.endEditing(true)
    }
    
    
    func calculate(brackets: [Double], rates: [Double]) {
        let formatter           = NSNumberFormatter()
        formatter.numberStyle   = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale        = NSLocale(localeIdentifier: "en_CA")
        
        if salaryTextField.text != "" {
            input = Double(salaryTextField.text!)!
            provincial          = taxed(input, brackets: brackets, rates: rates)
            federal             = taxed(input, brackets: federalBrackets, rates: federalRates)
            let result          = input - provincial - federal
            beforeTax.text      = formatter.stringFromNumber(input)
            provincialTax.text  = formatter.stringFromNumber(provincial)
            federalTax.text     = formatter.stringFromNumber(federal)
            afterTax.text       = formatter.stringFromNumber(result)
        }
    }
    
    
    /*
    *   Calculates the amount of taxes paid
    *   @salary   - salary to deduct taxes from
    *   @brackets - tax brackets fqor a given province
    *   @rates    - tax rates for a given province
    */
    func taxed(salary: Double, brackets: [Double], rates: [Double]) -> Double {
        var tax: Double = 0
        var i: Int
        //If salary is in the range of 0 and first bracket, calculate sum and break
        //Else if the salary is higher than the last range, sum all the ranges and add the final tax rate to the leftover sum
        //Else if the salary is within a range, sum the previous ranges and add it to the leftover sum
        if salary <= brackets[1] {
            tax += salary * rates[0]
        } else if salary > brackets[brackets.count - 1] {
            tax += bracketSum(brackets, rates: rates)
            tax += (salary - brackets[brackets.count - 1]) * rates[rates.count - 1]
        } else {
            for i = 1; i < brackets.count; i++ {
                tax += (brackets[i] - brackets[i - 1]) * rates[i - 1]
                if salary >= brackets[i - 1] && salary <= brackets[i] {
                    break
                }
            }
            tax += (salary - brackets[i]) * rates[i - 1]
        }
        return tax
    }
    /*
    *   Calculates the sum of tax paid in all the bracket ranges
    *   @brackets - tax brackets for a given province
    *   @rates    - tax rates for a given province
    */
    func bracketSum(brackets: [Double], rates: [Double]) -> Double {
        var sum: Double = 0
        for var i = 1; i < brackets.count; i++ {
            sum += (brackets[i] - brackets[i - 1]) * rates[i - 1]
        }
        return sum
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

