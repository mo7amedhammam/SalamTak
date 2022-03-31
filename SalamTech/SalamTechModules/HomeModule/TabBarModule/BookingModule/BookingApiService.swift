//
//  BookingApiService.swift
//  SalamTech
//
//  Created by wecancity on 31/03/2022.
//

import Foundation


import Foundation
import Alamofire

final class BookingApiService {
    
    static func GetDoctorDashboard( completion: @escaping ( Bool , ModelDashboard?, String?) -> ()) {
        
        let url = URLs().GetDoctorDashboard
//        let header:HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTUwNjcwNzMwIiwibmFtZWlkIjoiMjc2IiwianRpIjoiNDNkZTk2Y2MtMTliNC00NTRjLWE3ZjUtYTUyYjc5Njc2ZTIxIiwiZXhwIjoxNjQzMjc0MDY4LCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.g_FNtpKF1TcSWnrFGek4HA3ow82HktwaJkixQ41_51s"]
        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
        
        AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<ModelDashboard?, AFError>) in
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
                case 401 : print("The token expired (unauthorized)")
                    completion(false, nil, "unauthorized")

                case 400 : print("bad request get clinics")
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
