//
//  FetchData.swift
//  PryanikiTestCase
//
//  Created by Anya on 16.07.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    
     func getJSON(urlString: String, completion: @escaping (PryanikiJSON) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data else { return }
            
             do {
                let decoder = JSONDecoder()
                let pryanikiJson = try decoder.decode(PryanikiJSON.self, from: data)
                 
                 completion(pryanikiJson)
             } catch {
                 print(error)
             }
         }.resume()
     }
    
    //MARK: Testing
    func getFakeJSON(urlString: String, completion: @escaping (PryanikiJSON) -> ()) {
        
       let testBundle = Bundle(for: type(of: self))
       let path = testBundle.path(forResource: "pryanikiJSON", ofType: "json")
        
       guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else { return }
        
         do {
            let decoder = JSONDecoder()
            let pryanikiJson = try decoder.decode(PryanikiJSON.self, from: data)
             
             completion(pryanikiJson)
         } catch {
             print(error)
         }
    }
    
}