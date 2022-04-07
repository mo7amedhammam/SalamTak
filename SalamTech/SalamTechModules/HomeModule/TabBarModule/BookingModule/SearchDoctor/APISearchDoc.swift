//
//  APISearchDoc.swift
//  SalamTech
//
//  Created by wecancity on 05/04/2022.
//

import Foundation
import Alamofire




final class APISearchDoc {

static func SearchDoctors(parameters:[String:Any] ,completion: @escaping ( Bool , ModelSearchDoc?, String?) -> ()) {
    
    let url = URLs().DoctorSearch
    let header:HTTPHeaders = ["Content-Type":"application/json" ,"Authorization":Helper.getAccessToken()]
    let parameters : [String : Any] = parameters as [String : Any]
    print(parameters)
    
    AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
        .validate(statusCode: 200...500)
        .responseDecodable(completionHandler: { ( response : DataResponse<ModelSearchDoc?, AFError>) in
            
            
        ////////////////////////////////
            ///
            switch response.response?.statusCode {
            case 200 : print("Success Token")
        switch response.result {
            //--------------
        case .failure(let error):
            print(error.localizedDescription)
            completion(false, nil, error.localizedDescription)
            
        case .success(let model):
            guard model != nil else {return}
            if model?.success == true{
                
                completion(true, model , nil)
                print("clinic schedual created from api servise")
                //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
                
            } else{
                completion(false, nil, model?.message)
            }
            //-------------
        }
        case 401 : print("The token expired (unauthorized)")
        case 400 :  switch response.result {
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
//print("response")
//                    print(response)
//                    print("response.result")
//                    print(response.result)

        default: return
        }
        ///////////////////////////
    })
    
}
}
