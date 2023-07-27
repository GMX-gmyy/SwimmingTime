//
//  STRecordModel.swift
//  SwimmingTime
//
//  Created by 龚梦洋 on 2023/7/27.
//

import Foundation
import ObjectMapper

class STRecordModel: STBaseModel {
    
    var timeStrig: String?
    var distance: Int?
    var speed: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        timeStrig    <- map["timeStrig"]
        distance     <- map["distance"]
        speed        <- map["speed"]
    }
}
