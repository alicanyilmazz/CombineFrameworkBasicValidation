//
//  RegexValidationManager.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation
import UIKit

struct RegexValidationManagerImpl : ValidationManager{
    
    private let items: [RegexFormItem]
    
    init(_ items: [RegexFormItem]){
        self.items = items
    }
    
    func validate(_ val: Any) throws {
        let val = (val as? String) ?? ""
        
        try items.forEach({ regexItem in
            let regex = try? NSRegularExpression(pattern: regexItem.pattern, options: .allowCommentsAndWhitespace)
            let range = NSRange(location: 0, length: val.count)
            if regex?.firstMatch(in: val, options: [], range: range) == nil{
                throw regexItem.error
            }
        })
        
    }
}
