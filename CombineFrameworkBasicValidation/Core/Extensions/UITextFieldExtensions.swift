//
//  UITextFieldExtensions.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation
import UIKit

extension UITextField {
    
    func valid() {
        //self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    func invalid() {
        //self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemRed.cgColor
    }
}

extension UITextField {
    static var id: String {
        String(describing: self)
    }
}

