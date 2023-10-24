//
//  ViewController.swift
//  Profit
//
//  Created by Егор Ершов on 13.01.2022.
//

import UIKit

class ViewController: UIViewController{

    var prof = 0
    
    func getProfit() {
        prof = 0
        if !Operation.shared.operations.isEmpty {
            prof = Operation.shared.getProfit()
        }
        switch prof {
        case 1... :
            profit.textColor = UIColor(named: "green");
        case ..<0 :
            profit.textColor = UIColor(named: "bagryi");
        default:
            profit.textColor = .black
        }
        profit.text = String(prof)
    }
    
    @IBOutlet weak var operations: UITableView!
    @IBOutlet weak var profit: UILabel!
    @IBOutlet weak var addOperation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operations.dataSource = self
        operations.delegate = self
        
        addOperation.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getProfit()
        
        self.operations.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Operation.shared.operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oper", for: indexPath)
        let oper = Operation.shared.operations[indexPath.row]
        cell.textLabel?.text = "\(oper.amount) -> \(oper.dateString)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
            Operation.shared.deleteInfo(with: indexPath.row)
            self.getProfit()
            tableView.reloadData()
        }
        
        return [deleteAction]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InfoViewController {
            destination.pos = operations.indexPathForSelectedRow!.row
        }
    }
}
