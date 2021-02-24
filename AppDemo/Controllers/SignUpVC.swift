//
//  SignUpVC.swift
//  AppDemo
//
//  Created by KHUSHI on 17/02/21.
//

import UIKit

class SignUpVC: UIViewController {

    let color = Colors()
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet var view1: UIView!
    @IBOutlet var viewtxtEmail: UIView!
    @IBOutlet var viewtxtPassword: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initialize() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = color.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        self.viewtxtEmail.setCornerRadius(radius: self.viewtxtEmail.layer.frame.height/2)
        self.viewtxtPassword.setCornerRadius(radius: self.viewtxtEmail.layer.frame.height/2)
        self.btnSignUp.setCornerRadius(radius: 15)
    }
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        guard let email = txtEmail.text, let password = txtPassword.text else { return }
        if txtEmail.text == ""{
            let alertController = UIAlertController(title: nil, message: "Please Enter Email", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else if validateEmailId(emailID: email) == false  {
            let alertController = UIAlertController(title: nil, message: "Incorrect Email", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }else if txtPassword.text == ""{
            let alertController = UIAlertController(title: nil, message: "Please Enter Password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else if validatePassword(password: password) == false {
            let alertController = UIAlertController(title: nil, message: "Incorrect Password", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        else{
            self.signUpInFireBase()
        }
    }
   
    func signUpInFireBase(){
        //SIGNUP DATA IN FIREBASE
        let signUpmanager = FireBaseAuthManager()
        if let email = txtEmail.text, let password = txtPassword.text{
            signUpmanager.createUser(email: email, password: password) {[weak self] (success, error, uid) in
                guard let self = self else {return}
                var message : String = ""
                if (success){
                    
                    UserDefaults.standard.setValue(uid, forKey: "userid")
                    UserDefaults.standard.setValue(email, forKey: "email")
                    UserDefaults.standard.setValue(password, forKey: "password")
                    print(password)
                    
    
                }else{
                    message = error ?? ""
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    print(message)
                    
                }
            }
        }
    }

}
