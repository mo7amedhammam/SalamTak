//
//  UpdatePersonalDataApiService.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 09/04/2022.
//

import Foundation
import Alamofire
import SwiftUI

final class ScheduleApiService {
            
    static func GetPatientAppointmentInfo( medicalExaminationTypeId:Int,completion: @escaping ( Bool , ModelGetSchedule?, String?) -> ()) {
        
        let url = URLs().GetPatientAppointment
            let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
        let queryItems = [URLQueryItem(name:"medicalExaminationTypeId",value:"\(medicalExaminationTypeId)")]
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        let convertedUrl = urlComponents?.url
        if let convertUrl = convertedUrl {
            print(convertUrl)
        }
        
        AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200..<500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelGetSchedule?, AFError>) in
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
    
    //MARK: ------- cansel appointment  -----
    /// get takes appointment id - reason
    static func CanselAppointment(AppointmentId:Int , CancelReason :String ,completion: @escaping ( Bool , ModelCancelAppointment?, String?) -> ()) {
        
        let url = URLs().CancelAppointmen
        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
    let queryItems = [
        URLQueryItem(name:"AppointmentId",value:"\(AppointmentId)"),       //SkipCount starting record in list
        URLQueryItem(name:"CancelReason",value:"\(CancelReason)")   //MaxResultCount //num of items in single page
                    ]
    var urlComponents = URLComponents(string: url)
    urlComponents?.queryItems = queryItems
    let convertedUrl = urlComponents?.url
    if let convertUrl = convertedUrl {
        print(convertUrl)
    }
    
        
        AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelCancelAppointment?, AFError>) in
                switch response.response?.statusCode {
                case 200 : print("Success Token")
               
            ////////////////////////////////
                switch response.result {
                    //--------------
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false, nil, error.localizedDescription)
                    
                case .success(let model):
                    guard model != nil else { return }
                        if model?.success == true {
                        completion(true, model , model?.message ?? "")
                            print(model)
                        print(model?.message ?? "")
                    } else{
                        completion(false, model , model?.message ?? "")
                        print(model)
                        print(model?.message ?? "")
                    }
        
                    //-------------
                }
                case 401 : print("The token expired (unauthorized)")
                    completion(false, nil, "unauthorized")

                case 400 : print("bad request get current appointments")
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
