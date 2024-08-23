//
//  ListViewModel.swift
//  SwiftExamApp
//
//  Created by Tinku Sardar on 23/08/24.
//

import Foundation

struct APIRequest {
    
    var resourceURL: URL
    let urlString = APIUrl.APIDOMAIN
    
    init() {
        resourceURL = URL(string: urlString)!
    }
    
    //create method to get decode the json
    func requestAPIInfo(completion: @escaping(Result<DataModel, Error>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, response, error) in
            
            guard error == nil else {
                debugPrint (error!.localizedDescription)
                debugPrint ("stuck in data task")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let jsonData = try decoder.decode(DataModel.self, from: data!)
                SwiftModelObj.listData = jsonData
                completion(.success(jsonData))
            }
            catch {
                debugPrint ("an error in catch")
                debugPrint (error)
            }
        }
        dataTask.resume()
    }
}





