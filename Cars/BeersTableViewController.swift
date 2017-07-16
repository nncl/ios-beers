//
//  BeersTableViewController.swift
//  Cars
//
//  Created by Cauê Almeida on 7/16/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import UIKit

class BeersTableViewController: UITableViewController {

    var dataSource: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
    }
    
    func loadItems() {
        REST.loadItems { (items: [Beer]?) in
            if let items = items {
                self.dataSource = items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = dataSource[indexPath.row]
        cell.textLabel?.text = item.name
        // cell.detailTextLabel?.text = "\(item)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "edit" {
            let vc = segue.destination as! ViewController
            vc.beer = dataSource[tableView.indexPathForSelectedRow!.row]
        }
    }

}
