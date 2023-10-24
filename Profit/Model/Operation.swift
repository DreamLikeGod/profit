//
//  Operation.swift
//  Profit
//
//  Created by Егор Ершов on 18.01.2022.
//

import Foundation
import RealmSwift

class Info: Object{
    @objc dynamic var amount: Int = 0
    @objc dynamic var discript: String? = ""
    @objc dynamic var choise: Bool = false
    @objc dynamic var date: Date = Date()
    @objc dynamic var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        return formatter.string(from: date)
    }
}

class Operation {
    
    public static let shared = Operation()
    
    let realm = try! Realm()
    
    private init() {}
    
    public var operations: Results<Info>! {
        realm.objects(Info.self)
    }
    
    public func createInfo(with amount: Int, discript: String, choice: Bool, date: Date = Date()) {
        let oper = Info(value: [amount, discript, choice, date])
        try! realm.write {
            realm.add(oper)
        }
    }
    
    public func deleteInfo(with indexPath: Int) {
        let oper = operations[indexPath]
        try! realm.write {
            realm.delete(oper)
        }
    }
    
    public func getProfit() -> Int {
        var profit = 0
        for oper in operations {
            profit += oper.amount
        }
        return profit
    }
    
}
