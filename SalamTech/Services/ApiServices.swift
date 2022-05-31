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
    
    //MARK:  --------- ResetPasswordUser ------
    static func resetPassword( email:String ,completion: @escaping ( Bool , ModelResetPassword?, String?) -> ()) {
        
        let url = URLs().ResetPassword
        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
        let parameters : [String : Any] = ["Email" : email ,"UserTypeId" : 3 ]
        
        
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelResetPassword?, AFError>) in
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
                if model?.success == true{
                    completion(true, model, nil)
                    //                    print(model?.Message ?? "")
                    //                    print(model?.Data?.Code ?? "")
                    //                    print(model?.MessageCode ?? "")
                    
                    
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
    
    //MARK:  --------- UpdatePasswordUser ------
    static func updatePassword( userId: Int,password:String ,completion: @escaping ( Bool , ModelUpdatePassword?, String?) -> ()) {
        
        let url = URLs().UpdatePassword
        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
        let parameters : [String : Any] = ["Password" : password ,"UserId" : userId ]
        
        
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePassword?, AFError>) in
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
    
    static func updatePassword1(password:String ,completion: @escaping ( Bool , ModelUpdatePassword?, String?) -> ()) {
        
        let url = URLs().UpdatePassword
        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
        let parameters : [String : Any?] = ["Password" : password ]
        print(parameters)
         
        
        
        AF.request(url, method: .post,parameters: parameters as Parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePassword?, AFError>) in
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
//                    completion(false, nil,"Please Add Profile Image")
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
                        Helper.setUserData(Id: model?.data?.id ?? 0, PhoneNumber: "default phone ", patientName: "\(model?.data?.firstName ?? "")" + "\(model?.data?.middleName ?? "" )")
                        
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

    //MARK: ------- Get doctor Sub Specialist -----
    
    static func GetSubSpecialist(SpecialistId : Int, completion: @escaping ( Bool , ModelSubSpecialist?, String?) -> ()) {
        
        let url = URLs().GetSubSpecialist
//        let header:HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTUwNjcwNzMwIiwibmFtZWlkIjoiMjc2IiwianRpIjoiMzk4NTliYjktNTg5OS00ZmViLTgyNWYtMDBjNzBhOTkwN2JlIiwiZXhwIjoxNjQzMDIwMTMwLCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.loG66O08ib2SJjF9pum7UWDH-uSYztAzpiNP_8MNeQg"]
                let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//
        let queryItems = [URLQueryItem(name:"specialListId",value:"\(SpecialistId)")]
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        let convertedUrl = urlComponents?.url
        if let convertUrl = convertedUrl {
            print(convertUrl)
        }
        
        AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: URLEncoding.httpBody ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelSubSpecialist?, AFError>) in
            ////////////////////////////////
                
                switch response.response?.statusCode {
                case 200 : print("Success Token")
                switch response.result {
                    //--------------
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)

                    completion(false, nil, error.localizedDescription)
                    
                case .success(let model):
                    guard model != nil else {return}
                    if model?.Success == true {
                        print(model!)
                        completion(true, model , model?.Message ?? "")
                        
                    } else{
                        print(model?.Message ?? "")
                        
                        completion(false, model, model?.Message ?? "")
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
    
    
    static func GetSeniorityLevel( completion: @escaping ( Bool , ModelSeniorityLevel?, String?) -> ()) {
        
        let url = URLs().GetSeniorityLevel

        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
    
        
        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelSeniorityLevel?, AFError>) in
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
                    if model?.Success == true {
                        completion(true, model , model?.Message ?? "")
                        
                    } else{
                        print(model?.Message ?? "")
                        
                        completion(false, model, model?.Message ?? "")
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

}

final class NetworkLayer{

    static func request<T:Codable>(url:String,method:HTTPMethod, parameters:Parameters,header:HTTPHeaders,model:T.Type,completion: @escaping ( Bool , T?, String?) -> ()) {
        AF.request(url, method: method ,parameters: nil, encoding: URLEncoding.default)
        
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<T?, AFError>) in
                    
                    switch response.result{
                    case .success(let model):
                        
                        switch response.response?.statusCode{
                        case 200:
                            guard model != nil else {return}
                            completion(true, model , "success")
                            
                        case 400:                  //Bad Request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )

                        default: return

                        }

                    case .failure(let err):
                        switch response.response?.statusCode{
                        case 401:               //Unauthorized
                            completion(false, nil, err.localizedDescription)

                        default: return

                        }
                        
                    }

        })

    }
    
    
    }
