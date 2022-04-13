//
//  AddOperationViewController.swift
//  Profit
//
//  Created by Егор Ершов on 14.01.2022.
//

import UIKit

class AddOperationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var choiseOper: UISegmentedControl!
    @IBOutlet weak var moneyAmount: UITextField!
    @IBOutlet weak var operationDiscript: UITextView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moneyAmount.delegate = self
        self.operationDiscript.delegate = self
        operationDiscript.layer.cornerRadius = 20
        saveBtn.layer.cornerRadius = 20
        cancelBtn.layer.cornerRadius = 20
    }

    @IBAction func save(_ sender: UIButton) {
        if moneyAmount.hasText && Int(moneyAmount.text!) != 0 {
            var choice = true
            var amount = Int(moneyAmount.text!) ?? 0
            var descript = "Не добавлено описание"
            let date = Date()
            if choiseOper.selectedSegmentIndex == 1 {
                choice = false
                amount = 0 - amount
            }
            if isEdit && !operationDiscript.text.isEmpty {
                descript = operationDiscript.text
            }
            Operation.shared.saveOperation(amount: amount, discript: descript, choice: choice, date: date)
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moneyAmount.resignFirstResponder()
        operationDiscript.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moneyAmount.resignFirstResponder()
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if !isEdit {
            operationDiscript.text = ""
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        isEdit = true
    }
    
}
