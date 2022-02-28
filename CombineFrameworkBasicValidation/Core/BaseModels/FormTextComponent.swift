//
//  FormComponent.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation
import UIKit

final class FormSectionComponent : FormSectionItem, Hashable{
    let id: UUID = UUID()
    var items: [FormTextComponent]
    
    required init(items: [FormTextComponent]){
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormSectionComponent, rhs: FormSectionComponent) -> Bool{
        lhs.id == rhs.id
    }
}


class FormTextComponent: FormItem,Hashable{
   
    let id = UUID()
    let index : Int
    let formId: FormField
    var value: Any?
    var validations: [ValidationManager]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormTextComponent, rhs: FormTextComponent) -> Bool{
        lhs.id == rhs.id
    }
    
    init(id: FormField , index: Int , validations: [ValidationManager] = []){
        self.formId = id
        self.index = index
        self.validations = validations
    }
}

class FormButtonComponent{
   
    let id = UUID()
    let formId: FormField
 
    init(id: FormField){
        self.formId = id
    }
}
