//
//  STRecordManager.swift
//  SwimmingTime
//
//  Created by 龚梦洋 on 2023/7/27.
//

import Foundation

let stRecord = "stRecord"
class STRecordManager: NSObject {
    
    static let shared = STRecordManager()
    
    func saveRecordInfo(_ model: STRecordModel) {
        var models = getRecordInfo()
        models.append(model)
        UserDefaults.standard.setValue(models.toJSONString(), forKey: stRecord)
        UserDefaults.standard.synchronize()
    }
    
    func getRecordInfo() -> [STRecordModel] {
        let modelString = (UserDefaults.standard.value(forKey: stRecord) as? String) ?? ""
        let models = Array<STRecordModel>(JSONString: modelString)
        return models ?? []
    }
}
