//
//  TableViewController.swift
//  PryanikiTestCase
//
//  Created by Anya on 16.07.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var dataItems = [JSONObject]()
    var viewItems = [String]()
    var selectedItem: JSONObject?
    let urlString = "https://pryaniky.com/static/json/sample.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager.shared.getFakeJSON(urlString: urlString) { (json) in
            if let dataItems = json.data {
                self.dataItems = dataItems
            }
            
            if let viewItems = json.view {
                self.viewItems = viewItems
                
                //Вариант 2 - если нужно отображать только уникальные строки
//                self.viewItems = viewItems.reduce([], { $0.contains($1) ? $0 : $0 + [$1]})
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Oops", message: "No details for this item", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? TableViewCell else { return UITableViewCell()}
        
        cell.configure(with: viewItems[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = viewItems[indexPath.row]
        selectedItem = dataItems.filter{ $0.name == name}.first
        if (selectedItem != nil) {
            performSegue(withIdentifier: "detailsSegue", sender: self)
        } else {
            showAlert()
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedItem = selectedItem
        }
    }
    
    
}
