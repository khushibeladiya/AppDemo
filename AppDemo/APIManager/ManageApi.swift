//
//  GetMackUpData.swift
//  MakeupStore
//
//  Created by KHUSHI on 20/01/21.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

class ManageApi : NSObject{
    
    static let shared = ManageApi()
    
    //MARK:- Call MakeUp API
    func callMakeUpApi(homeVC : HomeVC){
        let url = String("http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline")
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON { (responseOBJ) in
            if responseOBJ.result.isSuccess{
                let response_arr : NSArray = responseOBJ.result.value! as! NSArray
                let objMackupModel : makeUpModel = makeUpModel()
                homeVC.arrAllData = objMackupModel.LoadDataToArray(arrDetail: response_arr)
//                homeVC.arrAllData = objMackupModel.LoadDataToArray(arrDetail: response_arr)
                
                //Data Insert into Localdatabase
                for data in homeVC.arrAllData {
                    homeVC.InsertDta(objModel: data)
                }
                homeVC.SelectData()
               
            }
        }
        
    }
    
}
