//
//  GetSpecialistAPI.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//

import Foundation
import Alamofire
import SwiftUI


final class GetSpecialistAPI{


//MARK: ------- Get doctor Specialist -----

static func GetSpecialist( completion: @escaping ( Bool , ModelSpecialist?, String?) -> ()) {
    
    let url = URLs().GetSpecialist

    let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]

    
    AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
        .validate(statusCode: 200...500)
        .responseDecodable(completionHandler: { ( response : DataResponse<ModelSpecialist?, AFError>) in
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
