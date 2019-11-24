//
//  ViewController.swift
//  Persisted JSON
//
//  Created by admin on 24/11/19.
//  Copyright © 2019 professional. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    let store = DataStore.shared
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.requestUsers() { [weak self] (users) in
            self?.users = users
            self?.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name! + " is  \(user.age) years old "
        cell.detailTextLabel?.text = String(user.id)
        return cell
    
    }
    
}

