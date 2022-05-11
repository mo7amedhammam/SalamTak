//
//  ReviewsApi.swift
//  SalamTech
//
//  Created by wecancity on 11/05/2022.
//

import Foundation
import Alamofire

final class ReviewsApi{

    static func GetDocReviews(doctorId:Int, completion: @escaping ( Bool , ReviewsModel?, String?) -> ()) {
    
        let url = URLs().DoctorRate
        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
        let queryItems = [URLQueryItem(name:"doctorId",value:"\(doctorId)")]
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        let convertedUrl = urlComponents?.url
        if let convertUrl = convertedUrl {
            print(convertUrl)
        }
    
    AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
        .validate(statusCode: 200..<500)
        .responseDecodable(completionHandler: { ( response : DataResponse<ReviewsModel?, AFError>) in
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
