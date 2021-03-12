//
//  MakeupModel.swift
//  MakeupStore
//
//  Created by KHUSHI on 20/01/21.
//

import Foundation

//MARK:- MakeUp Model
class makeUpModel : NSObject{
    
    var id : Int?
    var brand : String?
    var name : String?
    var price : String?
    var image : String?
    var descriptions : String?
    var rating : String?
    var catagory : String?
    var productType : String?
    var productColor : String?
    var productLink: String?
    
    override init() {
        
    }
    
    init(Dic : NSDictionary) {
        id = Dic.value(forKey: "id")as? Int
        brand = Dic.value(forKey: "brand")as? String
        name = Dic.value(forKey: "name")as? String
        price = Dic.value(forKey: "price")as? String
        image = Dic.value(forKey: "image_link")as? String
        descriptions = Dic.value(forKey: "description")as? String
        rating = Dic.value(forKey: "rating")as? String
        catagory = Dic.value(forKey: "category")as? String
        productType = Dic.value(forKey: "product_type")as? String
        productColor = Dic.value(forKey: "product_colors")as? String
        productLink = Dic.value(forKey: "product_link")as? String
    }
    //MARK:- LoadData function
    func LoadDataToArray(arrDetail : NSArray) -> [makeUpModel]{
        var objData : [makeUpModel] = []
        
        for arrDic in arrDetail{
            let objMackeUpModel = makeUpModel(Dic: arrDic as! NSDictionary)
//            let objMakeupViewMOdel = makeUpViewModel(mackUpModel: objMackeUpModel)
            objData.append(objMackeUpModel)
        }
        return objData
    }
}
//MARK:- MakeUp ViewModel
class makeUpViewModel : NSObject{
    
    var id : Int?
    var brand : String?
    var name : String?
    var price : String?
    var image : String?
    var descriptions : String?
    var rating : String?
    var catagory : String?
    var productType : String?
    var productColor : String?
    var productLink: String?
    
    override init() {
        
    }
    init(mackUpModel : makeUpModel) {
        id = mackUpModel.id!
        brand = mackUpModel.brand!
        name = mackUpModel.name!
        price = "$" + mackUpModel.price!
        image = mackUpModel.image!
        descriptions = mackUpModel.descriptions!
        rating = mackUpModel.rating
        catagory = mackUpModel.catagory
        productType = mackUpModel.productType!
        productColor = mackUpModel.productColor
        productLink = mackUpModel.productLink!
    }
}
