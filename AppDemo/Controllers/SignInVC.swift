//
//  SignInVC.swift
//  AppDemo
//
//  Created by KHUSHI on 17/02/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInVC: UIViewController,UITextFieldDelegate {

    //MARK: - Variables
    let color = Colors()
    //MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet var view1: UIView!
    @IBOutlet var lblsignIn: UILabel!
    @IBOutlet var viewtxtEmail: UIView!
    @IBOutlet var viewtxtPassword: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -  Intialize Function
    func initialize() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = color.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        self.viewtxtEmail.setCornerRadius(radius: self.viewtxtEmail.layer.frame.height/2)
        self.viewtxtPassword.setCornerRadius(radius: self.viewtxtEmail.layer.frame.height/2)
        self.btnSignIn.setCornerRadius(radius: 15)
        self.lblsignIn.text = NSLocalizedString("SignIn", comment: "")
    }

    //MARK: - Button SignIn Click
    @IBAction func btnIsSignInClick(_ sender: Any) {
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
            self.loginFireBase()
        }
    }
    
    //MARK: - Button SignUp Click
    @IBAction func btnIsSignUpClick(_ sender: Any) {
        let signupVC = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func loginFireBase(){
        //LOGIN DATA IN FIREBASE
        let loginManager = FireBaseAuthManager()
            guard let email = txtEmail.text, let password = txtPassword.text else { return }
        loginManager.signIn(email: email, password: password) {[weak self] (success,error,uid) in
            guard let self = self else { return }
            var message: String = ""
            if (success) {
                UserDefaults.standard.setValue(uid, forKey: "userid")
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(password, forKey: "password")
                
                let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                UserDefaults.standard.set(true, forKey: "login")
                self.navigationController?.pushViewController(homeVC, animated: true)
                //                    print(UserDefaults.value(forKey: "email"))
                message = "User was sucessfully logged in."
                self.txtEmail.text = ""
                self.txtPassword.text = ""
            } else {
                message = error ?? ""
                print(message)
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                print(message)
            }
            
        }
    }
}
