//
//  DataModel.swift
//  Task001
//
//  Created by Ankit Kumar Bharti on 30/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Node: NSObject {
    @objc dynamic var name: String
    
    override init() {
        self.name = "Untitled"
    }
    
    init(name: String) {
        self.name = name
    }
}
