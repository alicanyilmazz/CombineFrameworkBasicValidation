//
//  RegexEnums.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation

enum RegexPatterns{
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let between3to20 = "^.{3,20}$"
    static let name = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    static let between3to15 = "^.{3,15}$"
}
