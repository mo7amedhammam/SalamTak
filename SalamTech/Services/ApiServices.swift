//
//  ApiServices.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//


import Foundation
import Alamofire
import SwiftUI


final class ApiService{
    
    //MARK:  --------- RegisterUser ------
    static func userRegister(name:String, email:String, phone: String, password: String ,completion: @escaping ( Bool , ModelRegister?, String?) -> ()) {
        
        let url = URLs().RegisterUser
        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
        let parameters : [String : Any] = ["Name" : name ,"Email" : email ,"Phone" : phone ,"Password" : password ,"UserTypeId" : 3 ]
        
        
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelRegister?, AFError>) in
            ////////////////////////////////
                switch response.response?.statusCode {
                case 200 : print("Success Token")
            switch response.result {
                //--------------
            case .failure(let error):
                print(error.localizedDescription)
                completion(false, nil, error.localizedDescription)
                
            case .success(let model):
                guard model != nil else {return}
                //***************
                
                completion(true, model, nil)
                
                
                //******************
                if model?.Success == true{
                    completion(true, model, nil)
                    //                    print(model?.Message ?? "")
                    //                    print(model?.Data?.Code ?? "")
                    //                    print(model?.MessageCode ?? "")
                    
                    
                } else{
                    completion(false, nil, model?.Message)
                }
                //-------------
            }
                case 401 : print("The token expired (unauthorized)")
                case 400 : print("bad request")
                    switch response.result {
                          //--------------
                      case .failure(let error):
                          print(error.localizedDescription)
                          completion(false, nil, error.localizedDescription)
                          
                      case .success(let model):
                          guard model != nil else {return}
                      completion(false, model , model?.Message)
      //                print(model?.message ?? "")
      //                    if model?.success == false{
      //
      //                        completion(true, model , model?.message)
      //                        print(model?.message ?? "")
      //                        print("clinic schedual created from api servise")
      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
      //
      //                    } else{
      //                        completion(false, nil, model?.message)
      //                    }
                          //-------------
                      }

                default: return
                }
            ///////////////////////////
        })
        
        
        
    }
    
//    //MARK:  --------- ResetPasswordUser ------
//    static func resetPassword( email:String ,completion: @escaping ( Bool , ModelResetPassword?, String?) -> ()) {
//        
//        let url = URLs().ResetPassword
//        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
//        let parameters : [String : Any] = ["Email" : email ,"UserTypeId" : 2 ]
//        
//        
//        
//        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelResetPassword?, AFError>) in
//            ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//                
//            case .success(let model):
//                guard model != nil else {return}
//                //***************
//                
//                completion(true, model, nil)
//                
//                
//                //******************
//                if model?.success == true{
//                    completion(true, model, nil)
//                    //                    print(model?.Message ?? "")
//                    //                    print(model?.Data?.Code ?? "")
//                    //                    print(model?.MessageCode ?? "")
//                    
//                    
//                } else{
//                    completion(false, nil, model?.message)
//                }
//                //-------------
//            }
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//            ///////////////////////////
//        })
//        
//        
//        
//    }
//    
//    //MARK:  --------- UpdatePasswordUser ------
//    static func updatePassword( userId: Int,password:String ,completion: @escaping ( Bool , ModelUpdatePassword?, String?) -> ()) {
//        
//        let url = URLs().UpdatePassword
//        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
//        let parameters : [String : Any] = ["Password" : password ,"UserId" : userId ]
//        
//        
//        
//        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePassword?, AFError>) in
//            ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//                
//            case .success(let model):
//                guard model != nil else {return}
//                //***************
//                
//                completion(true, model, nil)
//                
//                
//                //******************
//                if model?.Success == true{
//                    completion(true, model, nil)
//                    //                    print(model?.Message ?? "")
//                    //                    print(model?.Data?.Code ?? "")
//                    //                    print(model?.MessageCode ?? "")
//                    
//                    
//                } else{
//                    completion(false, nil, model?.Message)
//                }
//                //-------------
//            }
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.Message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//            ///////////////////////////
//        })
//        
//        
//        
//    }
//    
//    static func updatePassword1(password:String ,completion: @escaping ( Bool , ModelUpdatePassword?, String?) -> ()) {
//        
//        let url = URLs().UpdatePassword
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//        let parameters : [String : Any?] = ["Password" : password ]
//        print(parameters)
//         
//        
//        
//        AF.request(url, method: .post,parameters: parameters as Parameters ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePassword?, AFError>) in
//            ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//                
//            case .success(let model):
//                guard model != nil else {return}
//                //***************
//                
//                completion(true, model, nil)
//                
//                
//                //******************
//                if model?.Success == true{
//                    completion(true, model, nil)
//                    //                    print(model?.Message ?? "")
//                    //                    print(model?.Data?.Code ?? "")
//                    //                    print(model?.MessageCode ?? "")
//                    
//                    
//                } else{
//                    completion(false, nil, model?.Message)
//                }
//                //-------------
//            }
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.Message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//            ///////////////////////////
//        })
//        
//        
//        
//    }
//    
    // MARK:  ----------  Create User --------------
    static func CreateUser(Name : String ,Email : String ,Phone : String ,Password : String ,completion: @escaping ( Bool , ModelCreateUser?, String?) -> ()) {
        
        let url = URLs().CreateUser
        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
        let parameters : [String : Any] = ["Name" : Name ,"Email" : Email ,"Phone" : Phone ,"Password" : Password , "UserTypeId" : 3]
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelCreateUser?, AFError>) in
            ////////////////////////////////
                switch response.response?.statusCode {
                case 200 : print("Success Token")
            switch response.result {
                //--------------
            case .failure(let error):
                print(error.localizedDescription)
                completion(false, nil, error.localizedDescription)
                
            case .success(let model):
                guard model != nil else {return}
                if model?.Success == true{
                    
                    completion(true, model , nil)
                    print("user created from api servise")
                    
                    Helper.setAccessToken(access_token: model?.Data?.Token ?? "")
                    Helper.setUserimage(userImage: URLs.BaseUrl+"\(model?.Data?.Image ?? "")")

                    
                } else{
                    completion(false, nil, model?.Message)
                }
                //-------------
            }
            case 401 : print("The token expired (unauthorized)")
            case 400 : print("bad request")
                    switch response.result {
                          //--------------
                      case .failure(let error):
                          print(error.localizedDescription)
                          completion(false, nil, error.localizedDescription)
                          
                      case .success(let model):
                          guard model != nil else {return}
                      completion(false, model , model?.Message)
      //                print(model?.message ?? "")
      //                    if model?.success == false{
      //
      //                        completion(true, model , model?.message)
      //                        print(model?.message ?? "")
      //                        print("clinic schedual created from api servise")
      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
      //
      //                    } else{
      //                        completion(false, nil, model?.message)
      //                    }
                          //-------------
                      }

            default: return
            }
            ///////////////////////////
        })
        
    }
//    
    // MARK:  ----------  LOGIN --------------
    static func LoginUser(phone: String, password: String ,completion: @escaping ( Bool , ModelLogin?, String?) -> ()) {
        
        let url = URLs().LoginUser
        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
        let parameters : [String : Any] = ["Phone" : phone ,"Password" : password,"UserTypeId" : 3 ]
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelLogin?, AFError>) in
            ////////////////////////////////
                switch response.response?.statusCode {
                case 200 : print("Success Token")
            switch response.result {
                //--------------
            case .failure(let error):
                print(error.localizedDescription)
                completion(false, nil, error.localizedDescription)
                
            case .success(let model):
                guard model != nil else {return}
                if model?.Success == true{
                    completion(true, model , nil)
                    
                } else{
                    completion(false, nil, model?.Message)
                }
                //-------------
            }
                case 401 : print("The token expired (unauthorized)")
                case 400 : print("bad request")
                    switch response.result {
                          //--------------
                      case .failure(let error):
                          print(error.localizedDescription)
                          completion(false, nil, error.localizedDescription)
                          
                      case .success(let model):
                          guard model != nil else {return}
                      completion(false, model , model?.Message)
      //                print(model?.message ?? "")
      //                    if model?.success == false{
      //
      //                        completion(true, model , model?.message)
      //                        print(model?.message ?? "")
      //                        print("clinic schedual created from api servise")
      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
      //
      //                    } else{
      //                        completion(false, nil, model?.message)
      //                    }
                          //-------------
                      }

                default: return
                }
            ///////////////////////////
        })
        
    }
//
    
    
//    //MARK: ------- Create Patient Profile With Upload MultipartData -----
    static func CreatePatientProfile( passedparameters : [String:Any],profileImage : UIImage?,
                                     completion: @escaping ( Bool , ModelCreatePatientProfile?, String?) -> ()) {
        
        let url = URLs().PatientCreateProfile
        let parameters : [String : Any] = passedparameters
        let header:HTTPHeaders = ["Content-Type":"multipart/form-data" ,
                                  "Authorization":Helper.getAccessToken()]

        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key , value) in parameters{
                
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray{
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
                if let data = profileImage?.jpegData(compressionQuality: 0.8), profileImage != nil {
                    //be carefull and put file name in withName parmeter
                    multipartFormData.append(data, withName: "profileImage" , fileName: "file.jpeg", mimeType: "image/jpeg")
                    //                    multipartFormData.append(data , withName: "profileImage", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
                    
                    // ---- To upload video ----
                    //                    multipartFormData.append(url, withName: "upload_data" , fileName: "movie.mp4", mimeType: "video/mp4")
              
                }else{ print("cant get image data")
                    completion(false, nil,"Please Add Profile Image")
                }
            
            
        },     to: url,
                  method: .post,
                  headers: header
        )
                
        
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelCreatePatientProfile?, AFError>) in
                ////////////////////////////////
//                print(response)
                switch response.response?.statusCode {
                case 200 : print("Success Token")
                switch response.result {
                    //--------------
                case .failure(let error):
                    completion(false, nil, error.localizedDescription)
                    
                case .success(let model):
                    guard model != nil else {return}
                    if model?.success == true {
                        completion(true, model , model?.message ?? "")
                        Helper.setUserData(Id: model?.data?.id ?? 0, PhoneNumber: "default phone ")
                        
                    } else{
                        print(model?.message ?? "")
                        completion(false, model, model?.message ?? "Fill Missing Data")
                    }
        
                    //-------------

                }
//
            case 401 : print("The token expired (unauthorized)")
                    //login again
                    completion(false, nil,"login again")

            case 400 : print("bad request create profile case 400")

       
                    switch response.result {
                          //--------------
                      case .failure(let error):
                          print(error.localizedDescription)
                          completion(false, nil, error.localizedDescription)
                            
                      case .success(let model):
                          guard model != nil else {return}
                      completion(false, model , model?.message)
                      
     
                          //-------------
                      }


            default: return
            }
                ///////////////////////////
            })
        
    }
    
//    static func CreatePatientMedicalState( passedparameters : [String:Any],
//                                     completion: @escaping ( Bool , ModelCreateMedicalState?, String?) -> ()) {
//
//        let url = URLs().PatientCreateMedicalInfo
//        let parameters : [String : Any] = passedparameters
//        let header:HTTPHeaders = ["Content-Type":"application/json" ,
//                                  "Authorization":Helper.getAccessToken()]
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//
//            for (key , value) in parameters{
//
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray{
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
////                if let data = profileImage?.jpegData(compressionQuality: 0.8), profileImage != nil {
////                    //be carefull and put file name in withName parmeter
////                    multipartFormData.append(data, withName: "profileImage" , fileName: "file.jpeg", mimeType: "image/jpeg")
////                    //                    multipartFormData.append(data , withName: "profileImage", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
////
////                    // ---- To upload video ----
////                    //                    multipartFormData.append(url, withName: "upload_data" , fileName: "movie.mp4", mimeType: "video/mp4")
////
////                }else{ print("cant get image data")
////                    completion(false, nil,"Please Add Profile Image")
////                }
//
//
//        },     to: url,
//                  method: .post,
//                  headers: header
//        )
//
//
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelCreateMedicalState?, AFError>) in
//                ////////////////////////////////
////                print(response)
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    completion(false, nil, error.localizedDescription)
//
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.success == true {
//                        completion(true, model , model?.message ?? "")
//                        Helper.setUserData(Id: model?.data?.id ?? 0, PhoneNumber: "default phone ")
//
//                    } else{
//                        print(model?.message ?? "")
//                        completion(false, model, model?.message ?? "Fill Missing Data")
//                    }
//
//                    //-------------
//
//                }
////
//            case 401 : print("The token expired (unauthorized)")
//                    //login again
//                    completion(false, nil,"login again")
//
//            case 400 : print("bad request create profile case 400")
//
//
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.message)
//
//
//                          //-------------
//                      }
//
//
//            default: return
//            }
//                ///////////////////////////
//            })
//
//    }
    
    
//

    static func CreatePatientMedicalState( passedparameters : [String:Any],completion: @escaping ( Bool , ModelCreateMedicalState?, String?) -> ()) {
        
        let url = URLs().PatientCreateMedicalInfo
        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json","Authorization":Helper.getAccessToken()]
        let parameters : [String : Any] = passedparameters
        
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelCreateMedicalState?, AFError>) in
            ////////////////////////////////
                switch response.response?.statusCode {
                case 200 : print("Success Tokennnn")
            switch response.result {
                //--------------
            case .failure(let error):
                print(error)
                completion(false, nil, error.localizedDescription)
                
            case .success(let model):
                guard model != nil else {return}
                if model?.success == true{
                    
                    completion(true, model , nil)
                    print("user created from api servise")
                    
//                    Helper.setAccessToken(access_token: model?.Data?.Token ?? "")
//                    Helper.setUserimage(userImage: URLs.BaseUrl+"\(model?.Data?.Image ?? "")")

                    
                } else{
                    completion(false, nil, model?.message)
                }
                //-------------
            }
            case 401 : print("The token expired (unauthorized)")
            case 400 : print("bad request")
                    switch response.result {
                          //--------------
                      case .failure(let error):
                          print(error.localizedDescription)
                          completion(false, nil, error.localizedDescription)
                          
                      case .success(let model):
                          guard model != nil else {return}
                      completion(false, model , model?.message)
      //                print(model?.message ?? "")
      //                    if model?.success == false{
      //
      //                        completion(true, model , model?.message)
      //                        print(model?.message ?? "")
      //                        print("clinic schedual created from api servise")
      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
      //
      //                    } else{
      //                        completion(false, nil, model?.message)
      //                    }
                          //-------------
                      }

            default: return
            }
            ///////////////////////////
        })
        
    }
//    
//    
//    //MARK: ------- Get doctor Specialist -----
//    
//    static func GetSpecialist( completion: @escaping ( Bool , ModelSpecialist?, String?) -> ()) {
//        
//        let url = URLs().GetSpecialist
////        let header:HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTUwNjcwNzMwIiwibmFtZWlkIjoiMjc2IiwianRpIjoiMzk4NTliYjktNTg5OS00ZmViLTgyNWYtMDBjNzBhOTkwN2JlIiwiZXhwIjoxNjQzMDIwMTMwLCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.loG66O08ib2SJjF9pum7UWDH-uSYztAzpiNP_8MNeQg"]
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//    
//        
//        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelSpecialist?, AFError>) in
//            ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.Success == true {
//                        completion(true, model , model?.Message ?? "")
//                        
//                    } else{
//                        print(model?.Message ?? "")
//                        
//                        completion(false, model, model?.Message ?? "")
//                    }
//        
//                    //-------------
//
//                }
//         
//
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.Message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//                ///////////////////////////
//            })
//        
//    }
//    
//    
//    
//    //MARK: ------- Get doctor Sub Specialist -----
//    
//    static func GetSubSpecialist(SpecialistId : Int, completion: @escaping ( Bool , ModelSubSpecialist?, String?) -> ()) {
//        
//        let url = URLs().GetSubSpecialist
////        let header:HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTUwNjcwNzMwIiwibmFtZWlkIjoiMjc2IiwianRpIjoiMzk4NTliYjktNTg5OS00ZmViLTgyNWYtMDBjNzBhOTkwN2JlIiwiZXhwIjoxNjQzMDIwMTMwLCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.loG66O08ib2SJjF9pum7UWDH-uSYztAzpiNP_8MNeQg"]
//                let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
////
//        let queryItems = [URLQueryItem(name:"specialListId",value:"\(SpecialistId)")]
//        var urlComponents = URLComponents(string: url)
//        urlComponents?.queryItems = queryItems
//        let convertedUrl = urlComponents?.url
//        if let convertUrl = convertedUrl {
//            print(convertUrl)
//        }
//        
//        AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: URLEncoding.httpBody ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelSubSpecialist?, AFError>) in
//            ////////////////////////////////
//                
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    print(error)
//
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.Success == true {
//                        print(model!)
//                        completion(true, model , model?.Message ?? "")
//                        
//                    } else{
//                        print(model?.Message ?? "")
//                        
//                        completion(false, model, model?.Message ?? "")
//                    }
//        
//                    //-------------
//
//                }
//         
//
//
//            case 401 : print("The token expired (unauthorized)")
//            case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.Message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//            default: return
//            }
//                ///////////////////////////
//            })
//        
//    }
//    
//    
//    static func GetSeniorityLevel( completion: @escaping ( Bool , ModelSeniorityLevel?, String?) -> ()) {
//        
//        let url = URLs().GetSeniorityLevel
//        
////        let header:HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTUwNjcwNzMwIiwibmFtZWlkIjoiMjc2IiwianRpIjoiMzk4NTliYjktNTg5OS00ZmViLTgyNWYtMDBjNzBhOTkwN2JlIiwiZXhwIjoxNjQzMDIwMTMwLCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.loG66O08ib2SJjF9pum7UWDH-uSYztAzpiNP_8MNeQg"]
//        
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//    
//        
//        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelSeniorityLevel?, AFError>) in
//            ////////////////////////////////
//            switch response.response?.statusCode {
//            case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.Success == true {
//                        completion(true, model , model?.Message ?? "")
//                        
//                    } else{
//                        print(model?.Message ?? "")
//                        
//                        completion(false, model, model?.Message ?? "")
//                    }
//        
//                    //-------------
//
//                }
//         
//
//            case 401 : print("The token expired (unauthorized)")
//            case 400 : print("bad request")
//                switch response.result {
//                      //--------------
//                  case .failure(let error):
//                      print(error.localizedDescription)
//                      completion(false, nil, error.localizedDescription)
//                      
//                  case .success(let model):
//                      guard model != nil else {return}
//                  completion(false, model , model?.Message)
//  //                print(model?.message ?? "")
//  //                    if model?.success == false{
//  //
//  //                        completion(true, model , model?.message)
//  //                        print(model?.message ?? "")
//  //                        print("clinic schedual created from api servise")
//  //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//  //
//  //                    } else{
//  //                        completion(false, nil, model?.message)
//  //                    }
//                      //-------------
//                  }
//
//            default: return
//            }
//
//                ///////////////////////////
//            })
//        
//    }
//
//    
//    
//    
//    //MARK: ------- Upload MultipartData -----
//    
//    static func uploadMultipart( passedparameters : [String:Any],yourImage : UIImage?, yourImageName : String,
//                                     completion: @escaping ( Bool , ModelDoctorCertificates?, String?) -> ()) {
//        
//        let url = URLs().DoctorCreateCertificate
//        let parameters : [String : Any] = passedparameters
//
//        let header:HTTPHeaders = ["Content-Type":"multipart/form-data" ,
//                                  "Authorization":Helper.getAccessToken()]
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for (key , value) in parameters{
//                
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray{
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//                if let data = yourImage?.jpegData(compressionQuality: 0.5), yourImage != nil{
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: yourImageName , fileName: "\(yourImageName).jpeg", mimeType: "image/jpeg")
//                    //                    multipartFormData.append(data , withName: "profileImage", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
//                    
//                    // ---- To upload video ----
//                    //                    multipartFormData.append(url, withName: "upload_data" , fileName: "movie.mp4", mimeType: "video/mp4")
//                }else{ completion(false, nil, "Certificate image is empty")  }
//           
//            
//        },     to: url,
//                  method: .post,
//                  headers: header
//        )
//        
//            .validate(statusCode: 200...500)
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelDoctorCertificates?, AFError>) in
//                ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.success == true {
//                        completion(true, model , model?.message ?? "")
//                        
//                    } else{
//                        print(model?.message ?? "")
//                        
//                        completion(false, model, model?.message ?? "Fill Missing Data")
//                    }
//        
//                    //-------------
//
//                }
//         
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//
//                ///////////////////////////
//            })
//        
//    }
//    
//    
//    static func uploadMultipartUpdate( passedparameters : [String:Any],yourImage : UIImage?, yourImageName : String,
//                                     completion: @escaping ( Bool , ModelDoctorCertificates?, String?) -> ()) {
//        
//        let url = URLs().DoctorUpdateCertificate
//        let parameters : [String : Any] = passedparameters
//
//        let header:HTTPHeaders = ["Content-Type":"multipart/form-data" ,
//                                  "Authorization":Helper.getAccessToken()]
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for (key , value) in parameters{
//                
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray{
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//                if let data = yourImage?.jpegData(compressionQuality: 0.5), yourImage != nil{
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: yourImageName , fileName: "\(yourImageName).jpeg", mimeType: "image/jpeg")
//                    //                    multipartFormData.append(data , withName: "profileImage", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
//                    
//                    // ---- To upload video ----
//                    //                    multipartFormData.append(url, withName: "upload_data" , fileName: "movie.mp4", mimeType: "video/mp4")
//                }else{ completion(false, nil, "Success")  }
//           
//            
//        },     to: url,
//                  method: .post,
//                  headers: header
//        )
//        
//            .validate(statusCode: 200...500)
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelDoctorCertificates?, AFError>) in
//                ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.success == true {
//                        completion(true, model , model?.message ?? "")
//                        
//                    } else{
//                        print(model?.message ?? "")
//                        
//                        completion(false, model, model?.message ?? "Fill Missing Data")
//                    }
//        
//                    //-------------
//
//                }
//         
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//
//                ///////////////////////////
//            })
//        
//    }
//    
//    
//    static func GetCertificates( completion: @escaping ( Bool , ModelGetCertificates?, String?) -> ()) {
//        
//        let url = URLs().DoctorGetCertificates
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
////        let queryItems = [URLQueryItem(name:"userId",value:"\(Helper.getUserID())")]
////        var urlComponents = URLComponents(string: url)
////        urlComponents?.queryItems = queryItems
////        let convertedUrl = urlComponents?.url
////        if let convertUrl = convertedUrl {
////            print(convertUrl)
////        }
//   
//        
//        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelGetCertificates?, AFError>) in
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//               
//            ////////////////////////////////
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.success == true {
//                        completion(true, model , model?.message ?? "")
//                        
//                    } else{
//                        print(model?.message ?? "")
//                        
//                        completion(false, model, model?.message ?? "")
//                    }
//        
//                    //-------------
//                }
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//                ///////////////////////////
//            })
//        
//    }
//        
//    
//    static func uploadLegalDocuments( passedparameters : [String:Any],yourImage : UIImage?, yourImageName : String,
//                                     completion: @escaping ( Bool , ModelLegalDocuments?, String?) -> ()) {
//        
//        let url = URLs().DoctorCreateLegalDocuments
//        let parameters : [String : Any] = passedparameters
//      
//        let header:HTTPHeaders = ["Content-Type":"multipart/form-data" ,
//                                  "Authorization":Helper.getAccessToken()]
//   
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for (key , value) in parameters{
//                
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray{
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//                if let data = yourImage?.pngData(), yourImage != nil{
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: yourImageName , fileName: "\(yourImageName).jpeg", mimeType: "image/jpeg")
//                    //                    multipartFormData.append(data , withName: "profileImage", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
//                    
//                    // ---- To upload video ----
//                    //                    multipartFormData.append(url, withName: "upload_data" , fileName: "movie.mp4", mimeType: "video/mp4")
//                }else{ }
//            
//            
//        },     to: url,
//                  method: .post,
//                  headers: header
//        )
//        
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .validate(statusCode: 200...500)
//
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelLegalDocuments?, AFError>) in
//                ////////////////////////////////
//                switch response.response?.statusCode {
//            case 200 : print("Success Token")
//
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.Success == true {
//                        completion(true, model , model?.Message ?? "")
//                        
//                    } else{
//                        print(model?.Message ?? "")
//                        
//                        completion(false, model, model?.Message ?? "Fill Missing Data")
//                    }
//        
//                    //-------------
//
//                }
//                    
//                           case 401 : print("The token expired (unauthorized)")
//                           case 400 : print("bad request")
//                               switch response.result {
//                                     //--------------
//                                 case .failure(let error):
//                                     print(error.localizedDescription)
//                                     completion(false, nil, error.localizedDescription)
//                                     
//                                 case .success(let model):
//                                     guard model != nil else {return}
//                                 completion(false, model , model?.Message)
//                 //                print(model?.message ?? "")
//                 //                    if model?.success == false{
//                 //
//                 //                        completion(true, model , model?.message)
//                 //                        print(model?.message ?? "")
//                 //                        print("clinic schedual created from api servise")
//                 //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//                 //
//                 //                    } else{
//                 //                        completion(false, nil, model?.message)
//                 //                    }
//                                     //-------------
//                                 }
//
//                           default: return
//                           }
//
//
//                ///////////////////////////
//            })
//        
//    }
//    
//    static func uploadClinicGallery( passedparameters : [String:Any],yourImage : UIImage?, yourImageName : String,
//                                     completion: @escaping ( Bool , ModelClinicGallery?, String?) -> ()) {
//        
//        let url = URLs().ClinicCreateGallery
//        let parameters : [String : Any] = passedparameters
//      
//        let header:HTTPHeaders = ["Content-Type":"multipart/form-data" ,
//                                  "Authorization":Helper.getAccessToken()]
//
//        
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            
//            for (key , value) in parameters{
//                
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray{
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//            if let data = yourImage?.jpegData(compressionQuality: 0.8), yourImage != nil{
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: yourImageName , fileName: "\(yourImageName).jpeg", mimeType: "image/jpeg")
//                    //                    multipartFormData.append(data , withName: "profileImage", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
//                    
//                    // ---- To upload video ----
//                    //                    multipartFormData.append(url, withName: "upload_data" , fileName: "movie.mp4", mimeType: "video/mp4")
//                }else{}
//            
//            
//        },     to: url,
//                  method: .post,
//                  headers: header
//        )
//        
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelClinicGallery?, AFError>) in
//                ////////////////////////////////
//                switch response.response?.statusCode {
//            case 200 : print("Success Token")
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.Success == true {
//                        completion(true, model , model?.Message ?? "")
//                        
//                    } else{
//                        print(model?.Message ?? "")
//                        
//                        completion(false, model, model?.Message ?? "Fill Missing Data")
//                    }
//        
//                    //-------------
//
//                }
//                
//                       case 401 : print("The token expired (unauthorized)")
//                       case 400 : print("bad request")
//                           switch response.result {
//                                 //--------------
//                             case .failure(let error):
//                                 print(error.localizedDescription)
//                                 completion(false, nil, error.localizedDescription)
//                                 
//                             case .success(let model):
//                                 guard model != nil else {return}
//                             completion(false, model , model?.Message)
//             //                print(model?.message ?? "")
//             //                    if model?.success == false{
//             //
//             //                        completion(true, model , model?.message)
//             //                        print(model?.message ?? "")
//             //                        print("clinic schedual created from api servise")
//             //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//             //
//             //                    } else{
//             //                        completion(false, nil, model?.message)
//             //                    }
//                                 //-------------
//                             }
//
//                       default: return
//                       }
//
//
//
//                ///////////////////////////
//            })
//        
//    }
//    
// 
//    
//    
//    static func GetAreaNameByID(AreaId:Int, completion: @escaping ( Bool , ModelGetAreaName?, String?) -> ()) {
//        
//        let url = URLs().GetAreanameByAreaId
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//        let queryItems = [URLQueryItem(name:"Id",value:"\(AreaId)")]
//        var urlComponents = URLComponents(string: url)
//        urlComponents?.queryItems = queryItems
//        let convertedUrl = urlComponents?.url
//        if let convertUrl = convertedUrl {
//            print(convertUrl)
//        }
//   
//        
//        AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelGetAreaName?, AFError>) in
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//               
//            ////////////////////////////////
//                switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//                    
//                case .success(let model):
//                    guard model != nil else {return}
//                    if model?.success == true {
//                        completion(true, model , model?.message ?? "")
//                        
//                    } else{
//                        print(model?.message ?? "")
//                        
//                        completion(false, model, model?.message ?? "")
//                    }
//        
//                    //-------------
//                }
//                case 401 : print("The token expired (unauthorized)")
//                case 400 : print("bad request get area by name")
//                    switch response.result {
//                          //--------------
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                          completion(false, nil, error.localizedDescription)
//                          
//                      case .success(let model):
//                          guard model != nil else {return}
//                      completion(false, model , model?.message)
//      //                print(model?.message ?? "")
//      //                    if model?.success == false{
//      //
//      //                        completion(true, model , model?.message)
//      //                        print(model?.message ?? "")
//      //                        print("clinic schedual created from api servise")
//      //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//      //
//      //                    } else{
//      //                        completion(false, nil, model?.message)
//      //                    }
//                          //-------------
//                      }
//
//                default: return
//                }
//                ///////////////////////////
//            })
//        
//    }
//  
//    static func DeleteCertificates(CertificateId:Int ,completion: @escaping ( Bool , ModelDeleteCertificates?, String?) -> ()) {
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//        let url = URLs().DoctorDeleteCertificates
////        let parameters : [String : Any] = passedparameters
//
//        let queryItems = [URLQueryItem(name:"CertificateId",value:"\(CertificateId)")]
//        var urlComponents = URLComponents(string: url)
//        urlComponents?.queryItems = queryItems
//        let convertedUrl = urlComponents?.url
//        if let convertUrl = convertedUrl {
//            print(convertUrl)
//        }
//
//
//        AF.request(convertedUrl!, method: .delete ,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelDeleteCertificates?, AFError>) in
//print(convertedUrl!)
//                
//            ////////////////////////////////
//                ///
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//
//            case .success(let model):
//                guard model != nil else {return}
//                if model?.success == true{
//
//                    completion(true, model , nil)
//                    print("CertificateId deleted from api servise")
//                    //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//
//                } else{
//                    completion(false, nil, model?.message)
//                }
//                //-------------
//            }
//            case 401 : print("The token expired (unauthorized)")
//            case 400 :  switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//
//                case .success(let model):
//                    guard model != nil else {return}
//                completion(false, model , model?.message)
////                print(model?.message ?? "")
////                    if model?.success == false{
////
////                        completion(true, model , model?.message)
////                        print(model?.message ?? "")
////                        print("clinic schedual created from api servise")
////                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
////
////                    } else{
////                        completion(false, nil, model?.message)
////                    }
//                    //-------------
//                }
////print("response")
////                    print(response)
////                    print("response.result")
////                    print(response.result)
//
//            default: return
//            }
//            ///////////////////////////
//        })
//
//    }
//    
//    static func DeleteDoctorDocument(DocumentId:Int ,completion: @escaping ( Bool , ModelDeleteCertificates?, String?) -> ()) {
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//        let url = URLs().DoctorDeleteLegalDocuments
////        let parameters : [String : Any] = passedparameters
//
//        let queryItems = [URLQueryItem(name:"DocumentId",value:"\(DocumentId)")]
//        var urlComponents = URLComponents(string: url)
//        urlComponents?.queryItems = queryItems
//        let convertedUrl = urlComponents?.url
//        if let convertUrl = convertedUrl {
//            print(convertUrl)
//        }
//
//
//        AF.request(convertedUrl!, method: .delete ,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelDeleteCertificates?, AFError>) in
//print(convertedUrl!)
//                
//            ////////////////////////////////
//                ///
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//
//            case .success(let model):
//                guard model != nil else {return}
//                if model?.success == true{
//
//                    completion(true, model , nil)
//                    print("CertificateId deleted from api servise")
//                    //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//
//                } else{
//                    completion(false, nil, model?.message)
//                }
//                //-------------
//            }
//            case 401 : print("The token expired (unauthorized)")
//            case 400 :  switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//
//                case .success(let model):
//                    guard model != nil else {return}
//                completion(false, model , model?.message)
////                print(model?.message ?? "")
////                    if model?.success == false{
////
////                        completion(true, model , model?.message)
////                        print(model?.message ?? "")
////                        print("clinic schedual created from api servise")
////                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
////
////                    } else{
////                        completion(false, nil, model?.message)
////                    }
//                    //-------------
//                }
////print("response")
////                    print(response)
////                    print("response.result")
////                    print(response.result)
//
//            default: return
//            }
//            ///////////////////////////
//        })
//
//    }
//    
//    
//    
//    static func DeleteGalleryImage(ClinicGalleryId:Int ,completion: @escaping ( Bool , ModelDeleteCertificates?, String?) -> ()) {
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//        let url = URLs().DoctorDeleteClinicGalleryId
////        let parameters : [String : Any] = passedparameters
//
//        let queryItems = [URLQueryItem(name:"ClinicGalleryId",value:"\(ClinicGalleryId)")]
//        var urlComponents = URLComponents(string: url)
//        urlComponents?.queryItems = queryItems
//        let convertedUrl = urlComponents?.url
//        if let convertUrl = convertedUrl {
//            print(convertUrl)
//        }
//
//
//        AF.request(convertedUrl!, method: .delete ,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelDeleteCertificates?, AFError>) in
//print(convertedUrl!)
//                
//            ////////////////////////////////
//                ///
//                switch response.response?.statusCode {
//                case 200 : print("Success Token")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//
//            case .success(let model):
//                guard model != nil else {return}
//                if model?.success == true{
//
//                    completion(true, model , nil)
//                    print("CertificateId deleted from api servise")
//                    //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
//
//                } else{
//                    completion(false, nil, model?.message)
//                }
//                //-------------
//            }
//            case 401 : print("The token expired (unauthorized)")
//            case 400 :  switch response.result {
//                    //--------------
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    completion(false, nil, error.localizedDescription)
//
//                case .success(let model):
//                    guard model != nil else {return}
//                completion(false, model , model?.message)
////                print(model?.message ?? "")
////                    if model?.success == false{
////
////                        completion(true, model , model?.message)
////                        print(model?.message ?? "")
////                        print("clinic schedual created from api servise")
////                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
////
////                    } else{
////                        completion(false, nil, model?.message)
////                    }
//                    //-------------
//                }
////print("response")
////                    print(response)
////                    print("response.result")
////                    print(response.result)
//
//            default: return
//            }
//            ///////////////////////////
//        })
//
//    }
    
    
    
}


//    init(formViewModel: FormViewModel) {
//        self.formViewModel = formViewModel
//      }
//    init () {
//
//        postMethod()
//    }
//    func postLogin() {
//
//        let urlString = "https://salamtech.azurewebsites.net/api/en/User/Register"
//
//        let parameters : [String : Any] = ["Email" : "mood@mdlvb.cpm" ,"Phone" : "01252525254" ,"Password" : "123456" ,"Name" : "mostafa" ,"UserTypeId" : 2 ]
//        AF.request(urlString, method: .post, parameters: parameters , encoding: JSONEncoding.default).responseJSON
//            { response in
//
////                let topVC = UIApplication.shared.keyWindow?.rootViewController
////
////                DispatchQueue.main.async {
////                    //Common_Methods.showHUD(view: (topVC?.view)!)
////                }
//
//                guard let data = response.data else { return }
//                print("data")
//                print(response.value!)
//
//
//
//                do {
//                    let decoder = JSONDecoder()
//
//                    let loginRequest = try decoder.decode(Response.self, from: data)
//                    self.response = loginRequest
//                    print(self.response ?? "")
////                    print(self.response?.ReSendCounter ?? "")
////                    print(self.response?.UserId ?? "")
//                    print(loginRequest.Message ?? "")
//
//                   // self.user = loginRequest
////                    for h in self.gameData{
////                        print(h.ReSendCounter)
////                    }
////                    print(loginRequest.Data!)  //ok
//
////                    print(self.user.Data)
////                    print(self.user?.Data.Code! ?? "default code")
//
//                    print("loginRequest")
//
//                    print(loginRequest)
////                    completion(loginRequest)
//                } catch let error {
//                    print(error)
////                    completion(nil)
//                }
//            }
//    }

//    func userRegister(fullname:String, email:String, phone: String, password: String ) {
//        /*
//         The following commented code is about when you want to make a POST call with parameters, like consumer key, consumer secret e.t.c
//         */
//
////        guard let components = URLComponents(string: "MY_URL") else {
////            print("Error: cannot create URLCompontents")
////            return
////        }
////        components.queryItems = [
////            URLQueryItem(name: "consumer_key", value: "MY_CONSUMER_KEY"),
////            URLQueryItem(name: "consumer_secret", value: "MY_CONSUMER_SECRET")
////        ]
////        guard let url = components.url else {
////            print("Error: cannot create URL")
////            return
////        }
//        guard let url = URL(string: "https://salamtech.azurewebsites.net/api/en/User/Register") else {
//            print("Error: cannot create URL")
//            return
//        }
//
//        // Create model
//        struct UploadData: Codable {
//            let Email: String
//            let Phone: String
//            let Password: String
//            let Name: String
//            let UserTypeId: Int
//        }
//
//        // Add data to the model
//        let uploadDataModel = UploadData(Email : email,
//                                         Phone : phone,
//                                         Password: password,
//                                         Name: fullname,
//                                         UserTypeId: 2)
//
//        // Convert model to JSON data
//        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
//            print("Error: Trying to convert model to JSON data")
//            return
//        }
//        // Create the url request
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
//        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
//        request.httpBody = jsonData
//        // If you are using Basic Authentication uncomment the follow line and add your base64 string
////        request.setValue("Basic MY_BASIC_AUTH_STRING", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print("Error: error calling POST")
//                print(error!)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
////                print(response)
//                return
//            }
////
////                self.openDetailsVC(jsonString: prettyPrintedJson, title: "POST METHOD")
//            if response.statusCode == 200 {
//                guard let data = data else {
//                    print("Error: Did not receive data")
//                    return
//                }
//                DispatchQueue.main.async {
//                    do{
//                        print("data")
//
//                        let decoder = JSONDecoder()
//
//                        let loginRequest = try decoder.decode(Response.self, from: data)
//                        self.response = loginRequest
//
//
//                        print(loginRequest)
//                        //self.response?.Data.ReSendCounter = prettyPrintedJson
//                        //print(prettyPrintedJson)
//                    } catch {
//                        print("Error: Trying to convert JSON data to string")
//                        return
//                    }
//                }
//
//            }
//
//
//        }.resume()
//    }


//do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                    print("Error: Cannot convert JSON object to Pretty JSON data")
//                    return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                    print("Error: Couldn't print JSON in String")
//                    return
//                }
//

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTUwNjcwNzMwIiwibmFtZWlkIjoiMjc2IiwianRpIjoiNjY2MTFmN2QtMTFiYy00MzVhLWEwNDItYTA3OTZhMzk0ZTdmIiwiZXhwIjoxNjQzMTE3OTEyLCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.IkqlS_2O1JmPqwYPGu8XnNnsGimCZ6uHjxW2Crlk73k

