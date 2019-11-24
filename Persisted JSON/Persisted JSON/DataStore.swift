//
//  DataStore.swift
//  Persisted JSON
//
//  Created by admin on 24/11/19.
//  Copyright © 2019 professional. All rights reserved.
//

import Foundation
import CoreData

class DataStore: NSObject {
    
    let persistence = PersistenceService.shared
    let networking  = NetworkingService.shared
    
    private override init() {
        super.init()
    }
    static let shared = DataStore()
    
    func requestUsers(completion: @escaping ([User]) -> Void) {
        //go out to the internet
        networking.request("https://kiloloco.com/api/users") { [weak self] (result) in
            switch result{
                
                 //get back some data
            case .success(let data):
                do {
                    guard
                        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {return}
                    
                  jsonArray.forEach {
                        guard
                            let strongSelf = self,
                            let name = $0["name"] as? String,
                            let age = $0["age"] as? Int16,
                            let id = $0["id"] as? Int16
                            else { return }
                        
                        let user = User(context: strongSelf.persistence.context)
                        user.name = name
                        user.age  = age
                        user.id   = id
                    }
                    
                            //save the data to core data
                    DispatchQueue.main.async{
                        self?.persistence.save{
                            self?.persistence.fetch(User.self, completion: { (objects) in
                                completion(objects)
                            })
                        }
                    }
                } catch {
                    print(error)
                }
            case .failure(let error): print(error)
            }
        }
        
       
        

        
        //return the data from core data
    }
    
}
