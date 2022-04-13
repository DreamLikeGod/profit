//
//  Operation.swift
//  Profit
//
//  Created by Егор Ершов on 18.01.2022.
//

import Foundation

class Operation {
    
    static let shared = Operation()
    
    let defaults = UserDefaults.standard
    
    struct Info: Codable {
        var amount: Int
        var discript: String?
        var choise: Bool = false
        var date: Date
        var dateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy HH:mm"
            return formatter.string(from: date)
        }
    }
    
    var operations: [Info] {
        get{
            if let data = defaults.value(forKey: "operations") as? Data {
                return try! PropertyListDecoder().decode([Info].self, from: data)
            } else {
                return [Info]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "operations")
            }
        }
    }
    
    func saveOperation(amount: Int, discript: String, choice: Bool, date: Date){
    
        let operation = Info(amount: amount, discript: discript, choise: choice, date: date)
        operations.insert(operation, at: 0)
        
    }
    
    func getProfit() -> Int {
        var profit = 0
        for oper in operations {
            profit += oper.amount
        }
        return profit
    }
    
}
