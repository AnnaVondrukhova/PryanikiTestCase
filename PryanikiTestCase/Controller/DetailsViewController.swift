//
//  DetailsViewController.swift
//  PryanikiTestCase
//
//  Created by Anya on 16.07.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var urlImageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var selectedItem: JSONObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = selectedItem.name ?? ""
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        guard let data = selectedItem.data else {
            print ("no data in selected item")
            return
        }
        
        congigureView(with: data)
    }
    
    private func congigureView(with data: JSONObjectData) {
        
        if (data.url == nil)&&(data.text == nil)&&(data.variants != nil)&&(!data.variants!.isEmpty) {
            let guide = view.safeAreaLayoutGuide
            tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        } else {
            if data.url != nil {
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                
                NetworkManager.getImageWithUrl(urlString: data.url!) { image in
                    self.activityIndicator.stopAnimating()
                    self.urlImageView.image = image
                }
            }
            
            if data.text != nil {
                textLabel.text = data.text
            }
        }
        if (data.variants != nil)&&(!(data.variants!.isEmpty)) {
            tableView.isHidden = false
        }
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedItem.data?.variants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "variantCell", for: indexPath) as? VariantCell, let variants = selectedItem.data?.variants else {
            return UITableViewCell()
        }
        
        let variantText = variants[indexPath.row].text ?? ""
        cell.configure(with: variantText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
