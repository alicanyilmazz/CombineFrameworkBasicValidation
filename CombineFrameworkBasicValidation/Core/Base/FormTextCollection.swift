//
//  FormComponentValidators.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 28.02.2022.
//

import Foundation
import UIKit
import Combine

class FormTextCollection{
    
    private(set) var subject = PassthroughSubject<(String,Int),Never>()
    private var subscriptions = Set<AnyCancellable>()
    
}

extension FormTextCollection{
    
    
     func setup(formComponent : FormTextComponent , textField : UITextField , label : UILabel, imageView : UIImageView){
       
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField).compactMap {
            ($0.object as? UITextField)?.text}.map(String.init).sink{ [weak self] val in
                guard let self = self else { return }
                
                self.subject.send((val,formComponent.index))
                
                do{
                    for validator in formComponent.validations{
                        try validator.validate(val)
                    }
                    
                    textField.valid()
                    label.text = "Everything seems ok."
                    label.textColor = .systemGreen
                    imageView.image = UIImage(systemName: "checkmark.circle")
                    imageView.tintColor = .systemGreen
                    
                }catch{
                    textField.invalid()
                    if let validationError = error as? ValidationError{
                        switch validationError {
                        case .custom(let message):
                            label.text = message
                            label.textColor = .systemPink
                            imageView.image = UIImage(systemName: "xmark.circle")
                            imageView.tintColor = .systemPink
                        }
                    }
                }
                
            }.store(in: &subscriptions)
    }
}

