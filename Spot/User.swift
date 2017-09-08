//
//  User.swift
//  Spot
//
//  Created by Winston Lan on 9/7/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import Foundation
import FirebaseAuth

class User {
    
    let uid: String
    let email: String
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
