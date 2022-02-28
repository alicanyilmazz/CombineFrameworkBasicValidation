//
//  FormComponentBuilder.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation
import Combine

final class formComponentBuilderImpl{
    
    private(set) var user = PassthroughSubject<[String : Any],Never>()
    
    private(set) var formContent = FormSectionComponent(items: [
            FormTextComponent(id: .name,index: 0, validations: [RegexValidationManagerImpl([RegexFormItem(pattern: RegexPatterns.between3to20, error: .custom(message: "Number of character must be 3 to 20")),RegexFormItem(pattern: RegexPatterns.name, error: .custom(message: "Name must be string"))])]),
            FormTextComponent(id: .email,index: 1, validations: [RegexValidationManagerImpl([RegexFormItem(pattern: RegexPatterns.between3to15, error: .custom(message: "Number of character must be 3 to 15")),RegexFormItem(pattern: RegexPatterns.email, error: .custom(message: "Invalid email format."))])]),
        ])
    
    
    func update(val: Any , componentIndex : Int){
        formContent.items[componentIndex].value = val
    }
    
    func validate(){
        do {
            let formComponents = formContent.items.compactMap{$0}.filter{$0.formId != .submit}
            for component in formComponents {
                for validator in component.validations{
                    try validator.validate(component.value as Any)
                }
            }
            let validValues = formComponents.map{($0.formId.rawValue,$0.value)}
            let validDict = Dictionary(uniqueKeysWithValues: validValues) as [String : Any]
            
            // Passthrough here
            user.send(validDict)
        } catch  {
            print("Something is wrong with form \(error)")
        }
    }
}
