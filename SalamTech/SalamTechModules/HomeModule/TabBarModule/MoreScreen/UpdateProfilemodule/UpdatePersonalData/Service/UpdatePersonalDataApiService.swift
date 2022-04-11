//
//  UpdatePersonalDataApiService.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 09/04/2022.
//

import Foundation
import Alamofire
import SwiftUI

final class UpdatePersonalApiService {
    
    static func UpdatePatientProfile( passedparameters : [String:Any],profileImage : UIImage?,
                                     completion: @escaping ( Bool , ModelUpdatePatientProfile?, String?) -> ()) {
        
        let url = URLs().PatientUpdateProfile
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
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePatientProfile?, AFError>) in
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
    
    
    static func GetPatientProfile( completion: @escaping ( Bool , ModelUpdatePatientProfile?, String?) -> ()) {
        
        let url = URLs().PatientGetProfile
            let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
        
        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200..<500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePatientProfile?, AFError>) in
                switch response.response?.statusCode {
                case 200 : print("Success")
            ////////////////////////////////
                switch response.result {
                    //--------------
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false, nil, error.localizedDescription)
                    
                case .success(let model):
                    guard model != nil else {return}
                    if model?.success == true {
                        completion(true, model , model?.message ?? "")
                        
                    } else{
                        print(model?.message ?? "")
                        
                        completion(false, model, model?.message ?? "")
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
}
