////
////  UpdatePersonalDataApiService.swift
////  SalamTech
////
////  Created by Mostafa Morsy on 09/04/2022.
////
//
//import Foundation
//import Alamofire
//import SwiftUI
//
//final class UpdatePersonalApiService {
//
//    static func UpdatePatientProfile( passedparameters : [String:Any],
//                                     completion: @escaping ( Bool , ModelUpdatePatientProfile?, String?) -> ()) {
//
//        let url = URLs().PatientUpdateProfile
//        let parameters : [String : Any] = passedparameters
//        let header:HTTPHeaders = ["Content-Type":"application/json" ,
//                                  "Authorization":Helper.getAccessToken()]
//
//        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200...500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePatientProfile?, AFError>) in
//            ////////////////////////////////
//                switch response.response?.statusCode {
//                case 200 : print("Success Tokennnn")
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error)
//                completion(false, nil, error.localizedDescription)
//
//            case .success(let model):
//                guard model != nil else {return}
//                if model?.success == true{
//
//                    completion(true, model , nil)
//                    print("user created from api servise")
//
////                    Helper.setAccessToken(access_token: model?.Data?.Token ?? "")
////                    Helper.setUserimage(userImage: URLs.BaseUrl+"\(model?.Data?.Image ?? "")")
//
//
//                } else{
//                    completion(false, nil, model?.message)
//                }
//                //-------------
//            }
//            case 401 : print("The token expired (unauthorized)")
//                    completion(false, nil,"unauthorized")
//
//            case 400 : print("bad request")
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
//            default: return
//            }
//            ///////////////////////////
//        })
//
//    }
//
//
//    static func GetPatientProfile( completion: @escaping ( Bool , ModelUpdatePatientProfile?, String?) -> ()) {
//
//        let url = URLs().PatientGetProfile
//            let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//
//        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//            .validate(statusCode: 200..<500)
//            .responseDecodable(completionHandler: { ( response : DataResponse<ModelUpdatePatientProfile?, AFError>) in
//                switch response.response?.statusCode {
//                case 200 : print("Success")
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
//
//                }
//
//
//            case 401 : print("The token expired (unauthorized)")
//                    completion(false, nil,"unauthorized")
//
//            case 400 : print("bad request")
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
//            default: return
//            }
//                ///////////////////////////
//            })
//
//    }
//}
