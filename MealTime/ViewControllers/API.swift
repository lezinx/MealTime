//
//  API.swift
//  MealTime
//
//  Created by Ziong on 09.06.2018.
//  Copyright © 2018 Ziong Le. All rights reserved.
//

import UIKit

enum Day : String {
    case Monday = "Понедельник "
    case Tuesday = "Вторник"
    case Wednesday = "Среда "
    case Thursday = "Четверг "
    case Friday = "Пятница "
}

class API: NSObject {
    
    static let shared = API()
    
    let service = GTLRSheetsService()
    let serviceApiKey = "AIzaSyBAKBwAKJwOBThbAisOeoYhu7eZSuR18sY"
    let spreadSheetId = "1NrPDjp80_7venKB0OsIqZLrq47jbx9c-lrWILYJPS88"
    
    func getProfiles(completion : @escaping ([[String]])->()) {
        let day = getDay()
        let rangeSet = "\(day)!A3:A34"
        executeQuery(rangeSet: rangeSet, completion: completion)
    }
    
    func getDishes(completion : @escaping ([[String]]) -> ()) {
        let day = getDay()
        let rangeSet = "\(day)!B2:M2"
        executeQuery(rangeSet: rangeSet, completion: completion)
    }
    
    func getProfileDishes(profileIndex: Int, completion : @escaping ([[String]])->()) {
        let day = getDay()
        let profileIndexEdited = profileIndex + 3
        let rangeSet = "\(day)!B\(profileIndexEdited):M\(profileIndexEdited)"
        executeQuery(rangeSet: rangeSet, completion: completion)
    }
    
    func executeQuery(rangeSet : String, completion : @escaping ([[String]]) -> ()) {
        let request = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadSheetId, range: rangeSet)
        
        self.service.apiKey = self.serviceApiKey
        
        self.service.executeQuery(request) { (ticket, response, error) in
            if let err = error {
                print("Error :\(err)")
                return
            }
            let value : GTLRSheets_ValueRange = response as! GTLRSheets_ValueRange
            completion(value.values as! [[String]])
        }
    }
    
    // MARK: Helpers
    func getDay() -> String {
        let dayInt = Calendar.current.component(.weekday, from: Date())
        
//        return Day.Friday.rawValue
        
        switch dayInt {
        case 0:
            return Day.Monday.rawValue
        case 1:
            return Day.Tuesday.rawValue
        case 2:
            return Day.Wednesday.rawValue
        case 3:
            return Day.Thursday.rawValue
        case 4:
            return Day.Friday.rawValue
        case 5:
            return Day.Monday.rawValue
        case 6:
            return Day.Monday.rawValue
        default:
            return Day.Monday.rawValue
        }
    }
    
}
