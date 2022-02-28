//
//  BaseFormComponent.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation

protocol FormItem{
    var id: UUID {get}
    var formId: FormField {get}
    var validations: [ValidationManager] {get}
}

protocol FormSectionItem{
    var id : UUID {get}
    var items: [FormTextComponent] {get}
    init(items: [FormTextComponent])
}


enum FormField: String,CaseIterable{
    case name
    case email
    case submit
}

