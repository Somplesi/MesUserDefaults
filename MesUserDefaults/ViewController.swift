//
//  ViewController.swift
//  MesUserDefaults
//
//  Created by Rodolphe DUPUY on 25/08/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var topSwitch: UISwitch!
    
    var array: [String] = [] {
        didSet {
            if oldValue != array {
                print("Old: \(oldValue), New: \(array)")
                userDefaults.set(array, forKey: arrayKey)
            }
        }
    }
    let arrayKey = "Key"
    let boolKey = "bool"
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setSwitch()
        setupTableView()
        getArray()
        
    }
    
    func setSwitch() {
        let bool = userDefaults.bool(forKey: boolKey)
        topSwitch.setOn(bool, animated: true)
    }
    
    //Obtenir et setter avec func
    func getArray() {
        if let newArray = userDefaults.array(forKey: arrayKey) as? [String] {
            array = newArray
        }
    }
//
//    func setArray(_ newArray: [String]) {
//        userDefaults.set(newArray, forKey: arrayKey)
//    }
    
    @IBAction func sendButton(_ sender: Any) {
        view.endEditing(true)
        if let text = textField.text, text != "" {
            //var newArray = array
            //newArray.append(text)
            //setArray(newArray)
            //getArray()
            array.append(text)
            tableView.reloadData()
            textField.text = nil
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: boolKey)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = array[indexPath.row]
        cell.textLabel?.text = item
        cell.textLabel?.textColor = userDefaults.bool(forKey: boolKey) ? .red : .label
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

