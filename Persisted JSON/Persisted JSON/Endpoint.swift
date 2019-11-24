//
//  DataObject.swift
//  Persisted JSON
//
//  Created by admin on 24/11/19.
//  Copyright © 2019 professional. All rights reserved.
//

import Foundation
import CoreData

enum Endpoint<T: NSManagedObject> {
    case users
        
    var urlPath:String{
        switch self {
        case .users: return  "https://kiloloco.com/api/users"
        }
        
       
    }
    
}
