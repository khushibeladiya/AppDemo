//
//  CreateUser.swift
//  FireBase.Demo
//
//  Created by Netra Technosys on 08/02/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class FireBaseAuthManager{
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ error : String?, _ uid: String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){(authResult,error) in
            if let user = authResult?.user{
                print(user.uid)
                completionBlock(true,nil,user.uid)
            }else{
                completionBlock(false,error?.localizedDescription,nil)
            }
        }
    }
    
    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ error : String?, _ uid: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false,error.localizedDescription,nil)
            } else {
                let user = result?.user
                completionBlock(true,nil,user?.uid)
            }
        }
    }
}

