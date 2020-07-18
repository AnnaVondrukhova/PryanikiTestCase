//
//  DetailsViewController.swift
//  PryanikiTestCase
//
//  Created by Anya on 16.07.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var urlAndTextView: UIView!
    @IBOutlet var urlImageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var selectedItem: JSONObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = selectedItem.name ?? ""
        
        guard let data = selectedItem.data else {
            print ("no data in selected item")
            return
        }
        
        congigureView(with: data)
    }
    
    private func congigureView(with data: JSONObjectData) {
        let guide = view.safeAreaLayoutGuide
        if (data.url == nil)&&(data.text == nil) {
            tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            print("height = 0")
        } else {
            if data.url != nil {
                urlImageView.image = getImageWithUrl(urlString: data.url!)
            }
            
            if data.text != nil {
                textLabel.text = data.text
            }
        }
        if (data.variants != nil)&&(!(data.variants!.isEmpty)) {
            tableView.isHidden = false
        }
    }
    
    private func getImageWithUrl(urlString: String) -> UIImage {
        guard let url = URL(string: urlString) else {return UIImage()}
        guard let imageData  = try? Data(contentsOf: url) else { return UIImage() }
        guard let image = UIImage(data: imageData) else { return UIImage() }
        
        return image
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
