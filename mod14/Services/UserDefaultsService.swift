//
//  UserDefaultsService.swift
//  mod14
//
//  Created by Solo Trant on 19/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import Foundation


class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    private let nameKey = "UserDefaultsService.nameKey"
    private let surnameKey = "UserDefaultsService.surnameKey"
    
    var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: nameKey) }
        get { return UserDefaults.standard.string(forKey: nameKey) }
    }
    
    var surname: String? {
        set { UserDefaults.standard.set(newValue, forKey: surnameKey) }
        get { return UserDefaults.standard.string(forKey: surnameKey) }
    }
    
}
