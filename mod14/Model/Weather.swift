//
//  Weather.swift
//  mod13
//
//  Created by Solo Trant on 14/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Currently: Object, Decodable {
    dynamic var time: Double = 0
    dynamic var temperature: Double = 0
    dynamic var summary: String = ""
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperature = "temperature"
        case summary = "summary"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        time = try container.decode(Double.self, forKey: .time)
        temperature = try container.decode(Double.self, forKey: .temperature)
        summary = try container.decode(String.self, forKey: .summary)
        
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "summary"
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)  {
        super.init(realm: realm, schema: schema)
    }
}

@objcMembers class DailyWeather: Object, Decodable {
    dynamic var time: Double = 0
    dynamic var temperatureHigh: Double = 0
    dynamic var summary: String = ""
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperatureHigh = "temperatureHigh"
        case summary = "summary"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        time = try container.decode(Double.self, forKey: .time)
        temperatureHigh = try container.decode(Double.self, forKey: .temperatureHigh)
        summary = try container.decode(String.self, forKey: .summary)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)  {
        super.init(realm: realm, schema: schema)
    }
}

@objcMembers class Daily: Object, Decodable {
    let data = RealmSwift.List<DailyWeather>()
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.decode([DailyWeather].self, forKey: .data)
        self.data.append(objectsIn: data)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)  {
        super.init(realm: realm, schema: schema)
    }
}

@objcMembers class Hourly: Object, Decodable {
    let data = RealmSwift.List<Currently>()
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.decode([Currently].self, forKey: .data)
        self.data.append(objectsIn: data)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)  {
        super.init(realm: realm, schema: schema)
    }
}

@objcMembers class Weather: Object, Decodable {
    dynamic var currently: Currently?
    dynamic var daily: Daily?
    dynamic var hourly: Hourly?
    
}
