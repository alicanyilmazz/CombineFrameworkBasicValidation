//
//  ViewController.swift
//  CombineFrameworkBasicValidation
//
//  Created by alican on 25.02.2022.
//

import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameWarningLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var nameLabelImage: UIImageView!
    @IBOutlet weak var emailLabelImage: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    private(set) var subject = PassthroughSubject<(String,String),Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private var indexPath: IndexPath?
    
    private lazy var formContentBuilder = formComponentBuilderImpl()
    private var nameFormTextCollection : FormTextCollection?
    private var emailFormTextCollection : FormTextCollection?
    private var sendFormButtonCollection : FormButtonCollection?
    

    override func viewDidLoad() {
       super.viewDidLoad()
       setupOutlets()
       bind()
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        sendFormButtonCollection?.subject.send(FormField.submit)
    }
    
    func newUserSubscription(){
        formContentBuilder.user.sink { [weak self] val in
            print(val)
        }.store(in: &subscriptions)
    }
}

extension ViewController{
    
    fileprivate func setupOutlets() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        
        nameTextField.borderStyle = .none
        emailTextField.borderStyle = .none
        
        nameView.layer.cornerRadius = 15
        nameView.clipsToBounds = false
        nameView.layer.shadowOpacity = 0.3
        nameView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        emailView.layer.cornerRadius = 15
        emailView.clipsToBounds = false
        emailView.layer.shadowOpacity = 0.3
        emailView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        
        sendButton.layer.cornerRadius = 10

    }
    
    fileprivate func bind(){
        nameFormTextCollection = FormTextCollection()
        emailFormTextCollection = FormTextCollection()
        sendFormButtonCollection = FormButtonCollection()
         
        guard let _nameFormTextCollection = nameFormTextCollection else { return }
        guard let _emailFormTextCollection = emailFormTextCollection else { return }
        guard let _sendFormButtonCollection = sendFormButtonCollection else { return }
         
        let _formContentBuilder = formContentBuilder.formContent.items
        
        newUserSubscription()
         
         _nameFormTextCollection.setup(formComponent: _formContentBuilder[0], textField: nameTextField, label: nameWarningLabel, imageView: nameLabelImage)
         _emailFormTextCollection.setup(formComponent: _formContentBuilder[1], textField: emailTextField, label: emailWarningLabel, imageView: emailLabelImage)
        
         _nameFormTextCollection.subject.sink { [weak self] (val , index) in
             self?.formContentBuilder.update(val: val, componentIndex: index)
         }.store(in: &subscriptions)
         
         _emailFormTextCollection.subject.sink { [weak self] (val , index) in
             self?.formContentBuilder.update(val: val, componentIndex: index)
         }.store(in: &subscriptions)
         
         _sendFormButtonCollection.subject.sink{ [weak self] formIdl in
             switch formIdl{
             case .submit: self?.formContentBuilder.validate()
             default: break
             }
         }.store(in: &subscriptions)
    }
    
}






