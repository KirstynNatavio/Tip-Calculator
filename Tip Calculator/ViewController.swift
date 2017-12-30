//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Kirstyn Natavio on 12/28/17.
//  Copyright © 2017 Kirstyn Natavio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numPeopleLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var splitAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
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
        billField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        stepper.minimumValue = 1.0
        stepper.isContinuous = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        billField.layer.borderColor = UIColor.white.cgColor
        billField.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let splitAmount = total / (Double(numPeopleLabel.text!) ?? 0)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        splitAmountLabel.text = String(format: "$%.2f", splitAmount)
        
    }
}

