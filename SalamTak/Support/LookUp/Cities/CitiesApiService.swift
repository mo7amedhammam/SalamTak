//
//  CitiesApiService.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//


import Foundation
import Alamofire

final class GetCitiesApiService{

//    static func GetCities( CountryId : Int, completion: @escaping ( Bool , ModelCities?, String?) -> ()) {
//
//        let url = URLs().GetCities
////        let header:HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTE0NDE2OTI0IiwibmFtZWlkIjoiMzY0IiwianRpIjoiOWRiZjU3MzktNGM5Yi00ZTE4LWFlMDQtMjBkYzU5OTgwYzdkIiwiZXhwIjoxNjQzNjMxMTc2LCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.EoKpSZbpmM1r0Wp8ufAluuBbeH1i4jgTDGOvVb7O9pk"]
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//    let queryItems = [URLQueryItem(name:"CountryId",value:"\(CountryId)")]
//    var urlComponents = URLComponents(string: url)
//    urlComponents?.queryItems = queryItems
//    let convertedUrl = urlComponents?.url
//    if let convertUrl = convertedUrl {
//        print(convertUrl)
//    }
//
//
//
//    AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//        .validate(statusCode: 200..<500)
//        .responseDecodable(completionHandler: { ( response : DataResponse<ModelCities?, AFError>) in
//            switch response.response?.statusCode {
//            case 200 : print("Success")
//        ////////////////////////////////
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//
//            case .success(let model):
//                guard model != nil else {return}
//                if model?.Success == true {
//                    completion(true, model , model?.Message ?? "")
//
//                } else{
//                    print(model?.Message ?? "")
//
//                    completion(false, model, model?.Message ?? "")
//                }
//
//                //-------------
//
//            }
//
//
//        case 401 : print("The token expired (unauthorized) city")
//        case 400 : print("bad request city")
//        default: return
//        }
//            ///////////////////////////
//        })
//
//}

    
//    static func GetCityByCityId( cityId : Int, completion: @escaping ( Bool , ModelCitYByCityId?, String?) -> ()) {
//
//        let url = URLs().GetCityById
//
//        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
//    let queryItems = [URLQueryItem(name:"Id",value:"\(cityId)")]
//    var urlComponents = URLComponents(string: url)
//    urlComponents?.queryItems = queryItems
//    let convertedUrl = urlComponents?.url
//    if let convertUrl = convertedUrl {
//        print(convertUrl)
//    }
//
//        AF.request(convertedUrl!, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
//        .validate(statusCode: 200..<500)
//        .responseDecodable(completionHandler: { ( response : DataResponse<ModelCitYByCityId?, AFError>) in
//            switch response.response?.statusCode {
//            case 200 : print("Success")
//        ////////////////////////////////
//            switch response.result {
//                //--------------
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(false, nil, error.localizedDescription)
//
//            case .success(let model):
//                guard model != nil else {return}
//                if model?.Success == true {
//                    completion(true, model , model?.Message ?? "")
//
//                } else{
//                    print(model?.Message ?? "")
//
//                    completion(false, model, model?.Message ?? "")
//                }
//
//                //-------------
//
//            }
//
//
//        case 401 : print("The token expired (unauthorized) city")
//        case 400 : print("bad request city by cityid")
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
//        default: return
//        }
//            ///////////////////////////
//        })
//
//}


}

