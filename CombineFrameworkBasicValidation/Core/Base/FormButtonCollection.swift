//
//  FormButtonCollection.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation
import Combine

class FormButtonCollection{
 
    private(set) var subject = PassthroughSubject<FormField,Never>()
    private var subscriptions = Set<AnyCancellable>()
    
}
