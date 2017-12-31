//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Kirstyn Natavio on 12/28/17.
//  Copyright © 2017 Kirstyn Natavio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var numPeopleLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var splitAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    func emptyTextField() {
        UIView.animate(withDuration: 0.1, animations: {
            self.contentView.frame.origin.y = 500
            self.billField.frame.size.height = 370
            self.billField.backgroundColor = UIColor(red: 87/255, green: 226/255, blue: 226/255, alpha: 1)
            self.billField.textColor = UIColor.white
        })
    }
    
    func contentTextField() {
        UIView.animate(withDuration: 0.1, animations: {
            self.contentView.frame.origin.y = 190
            self.billField.frame.size.height = 107
            self.billField.backgroundColor = UIColor.white
            self.billField.textColor = UIColor(red: 87/255, green: 226/255, blue: 226/255, alpha: 1)
        })
    }
    
    @IBAction func moveComponents(_ sender: UITextField) {
        if sender.text == "" {
            emptyTextField()
        }
        else {
            contentTextField()
            calculateTip(self)
        }
        
    }
    @IBAction func increaseNumPeople(_ sender: UIStepper) {
        let stepperVal = Int(sender.value)
        numPeopleLabel.text = String(stepperVal)
        calculateTip(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultPercentageIndex")
        calculateTip(self) // updating label values
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        emptyTextField()
        billField.placeholder = (Locale.current as NSLocale).displayName(forKey: .currencySymbol, value: Locale.current.currencyCode!) ?? "$"
        stepper.minimumValue = 1.0
        stepper.isContinuous = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        billField.layer.borderColor = UIColor.white.cgColor
        billField.layer.borderWidth = 1.0
        billField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        // view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = NSLocale.current
        currencyFormatter.maximumFractionDigits = 2

        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let tipText = tip as NSNumber
        let total = bill + tip
        let totalText = total as NSNumber
        let splitAmount = total / (Double(numPeopleLabel.text!) ?? 0)
        let splitAmountText = splitAmount as NSNumber
        tipLabel.text = currencyFormatter.string(from: tipText)
        totalLabel.text = currencyFormatter.string(from: totalText)
        splitAmountLabel.text = currencyFormatter.string(from: splitAmountText)
        
    }
}

