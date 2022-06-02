    //
    //  UserDefaults.swift
    //  NewsArticles
    //
    //  Created by Anastasia Kholod on 01.06.2022.
    //

import UIKit
class NewsUserDefaults: NSObject {
    
    class func saveSearchValue(newSearch:String) {
        var searchValues = UserDefaults.standard.object(forKey: "search") as? [String] ?? [String]()
        
        newSearch != "" && searchValues.contains(newSearch) == false ? searchValues.insert(newSearch, at: 0) : ()
        
        if searchValues.count > 6 {
            searchValues.remove(at: 6)
        }
        UserDefaults.standard.setValue(searchValues, forKey: "search")
    }
    
    class func searchValues() -> [String] {
        return  UserDefaults.standard.object(forKey: "search") as? [String] ?? [""]
    }
}
