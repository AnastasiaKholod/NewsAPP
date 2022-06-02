//
//  String.swift
//  NewsArticles
//
//  Created by Anastasia Kholod on 30.05.2022.
//

import UIKit

extension String {
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    func substring(to: Int) -> String? {
        if to > length {
            return nil
        } else if to == length {
            return self
        }
        let toIndex = index(startIndex, offsetBy: to)
        return substring(to: toIndex)
    }
    
    func substring(from: Int) -> String? {
        if from >= length {
            return nil
        }
        let fromIndex = index(startIndex, offsetBy: from)
        return substring(from: fromIndex)
    }
    
    func substring(from: Int, to: Int) -> String? {
        if (from >= to || to >= length) {
            return nil
        }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(startIndex, offsetBy: to)
        let range = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return substring(with: range)
    }
    
    func substring(from: Int, length: Int) -> String? {
        if from + length > self.length {
            return nil
        }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(fromIndex, offsetBy: length)
        let range = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return substring(with: range)
    }
}









