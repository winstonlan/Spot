//
//  Obligation.swift
//  Spot
//
//  Created by Winston Lan on 9/7/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Obligation {
    
    let key: String
    var name: String
    var amount: Int // In cents
    let addedByUser: String
    let ref: DatabaseReference?
    var completed: Bool
    
    init(name: String, amount: Int, addedByUser: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.amount = amount
        self.addedByUser = addedByUser
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        amount = snapshotValue["amount"] as! Int
        addedByUser = snapshotValue["addedByUser"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "amount": amount,
            "addedByUser": addedByUser,
            "completed": completed
        ]
    }
}
