//
//  DateNormalizer.swift
//  mod13
//
//  Created by Solo Trant on 18/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import Foundation


class DateNormalizer {
    
    static let shared = DateNormalizer()
    
    let formatter = DateFormatter()
    
    private init() {
        formatter.locale = Locale(identifier: "ru")
    }
    
    func normalize(date: Double) -> String {
        formatter.dateFormat = "dd MMMM"
        let normDate = Date(timeIntervalSince1970: date)
        let stringDate = formatter.string(from: normDate)
        
        return stringDate
    }
    
    func normalizeWithHours(date: Double) -> String {
        formatter.dateFormat = "HH:mm"
        let normDate = Date(timeIntervalSince1970: date)
        let stringDate = formatter.string(from: normDate)
        
        return stringDate
    }
}
