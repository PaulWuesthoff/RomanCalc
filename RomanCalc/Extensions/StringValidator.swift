//
//  StringValidator.swift
//  RomanCalc
//
//  Created by Paul Wüsthoff on 18.07.20.
//  Copyright © 2020 Paul Wüsthoff. All rights reserved.
//

import Foundation

extension String {
    func isValid() -> Bool {
        let format = "SELF MATCHES %@";
        let regex = "^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$";
        return NSPredicate(format: format, regex).evaluate(with: self);
    }
}

extension String {
func toArabic() -> Int? {
    var string = self as String
    
    let values = [("M", 1000), ("CM", 900), ("D", 500), ("CD", 400), ("C",100), ("XC", 90), ("L",50), ("XL",40), ("X",10), ("IX", 9), ("V",5),("IV",4), ("I",1)]
    
    var result = 0
    
    for (romanChars, arabicValue) in values {
        let range = romanChars.startIndex ..< romanChars.endIndex
        
        while string.hasPrefix(romanChars) {
            result = result + arabicValue
            
            #if swift(>=3.0)
            string.removeSubrange(range)
            #else
            string.removeRange(range)
            #endif
        }
    }
    
    if (string.isEmpty) {
        return result
    }
    
    return nil
    }
}
