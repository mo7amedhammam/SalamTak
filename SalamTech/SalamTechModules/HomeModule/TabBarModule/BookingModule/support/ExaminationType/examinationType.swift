//
//  examinationType.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//

import Foundation

import Alamofire
final class GetExaminationTypeIdApiServise {
    //MARK: ------- Get Schedual  -----
    
    static func GetExaminationTypeIdApiServise( completion: @escaping ( Bool , ModelExaminationTypeId?, String?) -> ()) {
        
//        let header:HTTPHeaders = [:]
        let url = URLs().GetMedicalExaminationType
      
        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: nil )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelExaminationTypeId?, AFError>) in
                switch response.response?.statusCode {
                case 200 : print("Success Token")
               
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
                case 401 : print("The token get clinic gallery by clinic id expired (unauthorized)")
                    completion(false, nil, "unauthorized")

                case 400 : print("bad request get clinic gallery by clinic id")
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

