//
//  HomeVC.swift
//  AppDemo
//
//  Created by KHUSHI on 25/02/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tblProduct: UITableView!

    
    //MARK: - Variables
    //Api Array
    var arrAllData : [makeUpModel] = []
    //LocalDatabase Array
    var arrData : [makeUpModel] = []
    let color = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        ManageApi.shared.callMakeUpApi(homeVC: self)
        // Do any additional setup after loading the view.
    }
    
    func initialize() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = color.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
    }
    
    //MARK: - InsertData in DataBase
    func InsertDta(objModel : makeUpModel){
        let obj_FMDB = FMDatabase(path: AppDelegate.appDelegate?.strDataBasePath)
        if obj_FMDB.open() {
            //MARK: - SelectData to Update record
            let selectQurey =  "select * from Product where rating = '\(objModel.id!)'"
            let result = obj_FMDB.executeQuery(selectQurey, withParameterDictionary: [:])
            if result!.next() {
                let updateQuery = "update Product set name = '\(objModel.name!)', price = '\(objModel.price!)', image = '\(objModel.image!)',productApiUrl = '\(objModel.productLink!)', catagory = '\("update")' where rating = '\(objModel.id!)' "
                if obj_FMDB.executeUpdate(updateQuery, withArgumentsIn: []){
                }else{
                    print(objModel.id!)
                    print("Data not been updated")
                }
            } else {
                let insertQuery = "insert into Product(name,price,image,rating,productApiUrl,catagory) values ('\(objModel.name!)','\(objModel.price!)','\(objModel.image!)','\(objModel.id!)','\(objModel.price!)','\("insert")')"
                if obj_FMDB.executeUpdate(insertQuery, withArgumentsIn: []){
                }else{
                    print("Data not been inserted")
                }
            }
            obj_FMDB.close()
        }

    }
    
    //MARK: - SelectData from Database
    func SelectData() {
        let obj_FMDB = FMDatabase(path: AppDelegate.appDelegate?.strDataBasePath)
        if obj_FMDB.open(){
            let selectQuery : String = "select name,price,image,productApiUrl from Product"
            print(selectQuery)
            let result = obj_FMDB.executeQuery(selectQuery, withParameterDictionary: [:])
            while  result!.next() {
                let objModel = makeUpModel()
                objModel.price = result!.string(forColumn: "price")
                objModel.image = result!.string(forColumn: "image")
                objModel.name = result!.string(forColumn: "name")
                objModel.productLink = result!.string(forColumn: "productApiUrl")
//                objModel.image = result!.string(forColumn: "image")
//                print(objModel.price!)
                arrData.append(objModel)
                //print(arrData)

            }
            obj_FMDB.close()
        }
    }
    

}
