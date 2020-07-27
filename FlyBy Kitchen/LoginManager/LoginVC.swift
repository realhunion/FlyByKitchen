//
//  LoginVC.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/14/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import QuickLayout

//class LoginVC: UITableViewController {}
    
class LoginVC: UIViewController, UITextFieldDelegate {
    
    let passwordPlaceholder : String = "Password"
    let emailPlaceholder : String = "Email"
    
    
    lazy var logoImageView: UILabel = {
        let label = UILabel()
        
        label.text = "FlyBy Kitchen"
        label.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var emailTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.layer.cornerRadius = 6
        textField.backgroundColor = UIColor.tertiarySystemGroupedBackground
        textField.textAlignment = NSTextAlignment.left
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 11.0
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
//        textField.textColor = UIColor.systemGray
        
        textField.typingAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        textField.attributedPlaceholder = NSAttributedString(string: self.emailPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: Constant.textfieldPlaceholderGray])
        
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.clear.cgColor
        
        textField.keyboardType = UIKeyboardType.alphabet
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        
        textField.delegate = self
        
        return textField
    }()
    
    lazy var passTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.layer.cornerRadius = 6
        textField.backgroundColor = UIColor.tertiarySystemGroupedBackground
        textField.textAlignment = NSTextAlignment.left
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 11.0
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        //        textField.textColor = UIColor.systemGray
        
        textField.typingAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        textField.attributedPlaceholder = NSAttributedString(string: self.passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: Constant.textfieldPlaceholderGray])
        
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.clear.cgColor
        
        textField.keyboardType = UIKeyboardType.alphabet
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        
        textField.isSecureTextEntry = true
        
        textField.delegate = self
        
        return textField
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
        
        self.setupPaddingView()
        self.setupLogoView()
        self.setupEmailField()
        self.setupPassField()
        self.setupLoginButton()
        
        emailTextField.text = "r1@gmail.com"
        passTextField.text = "pppppp"
    }
    
    
    
    var paddingView : UIView = UIView()
    func setupPaddingView() {
        
        self.view.addSubview(paddingView)
//        paddingView.layoutToSuperview(.top, offset: self.view.bounds.height*0.5)
        paddingView.layoutToSuperview(.centerY)
        //FIX
        paddingView.layoutToSuperview(.left, offset: self.view.bounds.width*0.10)
        paddingView.layoutToSuperview(.right, offset: -self.view.bounds.width*0.10)
        
    }
    
    
    func setupLogoView() {
        
        paddingView.addSubview(logoImageView)
        logoImageView.layoutToSuperview(.top, offset: 0)
        logoImageView.layoutToSuperview(.left, offset: 0)
        logoImageView.layoutToSuperview(.right, offset: 0)
        
        
    }
    
    func setupEmailField() {
        
        paddingView.addSubview(emailTextField)
        emailTextField.layout(.top, to: .bottom, of: logoImageView, offset: 16.0)
        
        emailTextField.layoutToSuperview(.left)
        emailTextField.layoutToSuperview(.right)
        emailTextField.set(.height, of: 44)
        //        logoImageView.set(.width, of: 120)
        
        
    }
    
    
    func setupPassField() {
        
        paddingView.addSubview(passTextField)
        passTextField.layout(.top, to: .bottom, of: emailTextField, offset: 10.0)

        passTextField.layoutToSuperview(.left)
        passTextField.layoutToSuperview(.right)
        passTextField.set(.height, of: 44)
        //        logoImageView.set(.height, of: 120)
        //        logoImageView.set(.width, of: 120)
        
        
    }
    
    func setupLoginButton() {
        
        paddingView.addSubview(loginButton)
        loginButton.layout(.top, to: .bottom, of: passTextField, offset: 10.0)
//        loginButton.layoutToSuperview(.left, offset: 0)
//        loginButton.layoutToSuperview(.right, offset: 0)
        loginButton.layoutToSuperview(.bottom, offset: 0)
        
        loginButton.layoutToSuperview(.left)
        loginButton.layoutToSuperview(.right)
        loginButton.set(.height, of: 44)
        
        
    }
    
    
    
    

}
