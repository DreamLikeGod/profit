//
//  InfoViewController.swift
//  Profit
//
//  Created by Егор Ершов on 22.01.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var operTime: UILabel!
    
    @IBOutlet weak var conteinerInfo: UIView!
    @IBOutlet weak var operAmount: UILabel!
    @IBOutlet weak var operDiscription: UITextView!
    
    var pos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conteinerInfo.layer.cornerRadius = 40
        operDiscription.layer.cornerRadius = 20
        
        let money = Operation.shared.operations[pos].amount
        let discript = Operation.shared.operations[pos].discript ?? ""
        
        switch money {
        case ..<0:
            operAmount.textColor = .red
        case 1...:
            operAmount.textColor = .green
        default :
            operAmount.textColor = .black
        }
        operAmount.text = String(money)
        operDiscription.text = discript
        operTime.text = Operation.shared.operations[pos].dateString
    }
    
}
