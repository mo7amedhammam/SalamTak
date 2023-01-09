//
//  BaseNetwork.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 01/06/2022.
//

import Foundation
import Alamofire
import Combine

func buildparameter(paramaters:parameterType)->([String:Any],ParameterEncoding){
    switch paramaters{
    case .plainRequest:
        return ([:],URLEncoding.default)
    case .parameterRequest(Parameters: let Parameters, Encoding: let Encoding):
        return(Parameters,Encoding)
    }
}

class BaseNetwork<T:TargetType>{

    func makeRequest<M:Codable>(Target:T,Model:M.Type
    ) -> AnyPublisher<M ,Error> {
        return Future { promise in
            
                     let url = Target.url
                    let method: HTTPMethod = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
            let parameters = buildparameter(paramaters: Target.parameter)
                    let headers: HTTPHeaders? = Alamofire.HTTPHeaders(Target.header ?? [:])
            AF.request(url, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(M.self, from: data)
                            promise(.success(model))
                        } catch {
                            promise(.failure(NetworkError.unableToParseData("cant pars data")))
                        }
                    case .failure(let error):
                        promise(.failure(NetworkError.unableToParseData(error.localizedDescription)))
                    }
                }
            
//                .responseDecodable(of: M.self, decoder: JSONDecoder()){ response in
//                    switch response.result {
//                    case .success(let model):
////                        if response.response?.statusCode == 200{ // success
////                            guard model != nil else {return}
//                            promise(.success(model))
////                        }else if response.response?.statusCode == 400  { // bad request
////                            guard model != nil else {return}
////                            promise(.failure(NetworkError.badRequest(code: 400, error: "bad req")))
//
////                        }else if response.response?.statusCode == 401 {
//////                            guard model != nil else {return}
////                            promise(.failure(NetworkError.unauthorized(code: 401, error: "token needed")))
////                        }
//                    case .failure(let error):
////                        if response.response?.statusCode == 401 {  //Unauthorized
//                        promise(.failure(NetworkError.unknown(code: 0, error: error.localizedDescription)))
////                        }else{
////                        }
//                    }
//                }
            
        }
        .eraseToAnyPublisher()
    }
    
    
    func makeMultipartRequest<M: Codable>(Target:T,Model:M.Type

    ) -> AnyPublisher<M, NetworkError> {
        return Future { promise in
            
                     let url = Target.url
                    let method: HTTPMethod = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
            let parameters = buildparameter(paramaters: Target.parameter)
                    let headers: HTTPHeaders? = Alamofire.HTTPHeaders(Target.header ?? [:])

            
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key , value) in parameters.0{
                    
                    if let tempImg = value as? UIImage{
                        if let data = tempImg.jpegData(compressionQuality: 0.8), (tempImg.size.width ) > 0 {
                                //be carefull and put file name in withName parmeter
                                multipartFormData.append(data, withName: key , fileName: "file.jpeg", mimeType: "image/jpeg")
                            }
//                        else{
//                                print("cant get image data")
//            //                    completion(false, nil,"imageError")
//                            }
                    }
                    
                    if let tempStr = value as? String {
                        multipartFormData.append(tempStr.data(using: .utf8)!, withName: key)
                    }
                    if let tempInt = value as? Int {
                        multipartFormData.append("\(tempInt)".data(using: .utf8)!, withName: key)
                    }
                    if let tempArr = value as? NSArray{
                        tempArr.forEach({ element in
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
                
    //            if let image = image {
    //                    let imageData = image.jpegData(compressionQuality: 1.0)!
    //                    let imageName = "image.jpg"
    //                parameters["profileImage"] = imageData
    //            }
                

            },     to: url,
                      method: method,
                      headers: headers
            )
                .responseData { response in

                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(M.self, from: data)
                            promise(.success(model))
                        } catch {
                            promise(.failure(NetworkError.unableToParseData("cant pars data")))
                        }
                    case .failure(let error):
                        promise(.failure(NetworkError.unableToParseData(error.localizedDescription)))
                    }
                }
//                .responseDecodable(of: M.self, decoder: JSONDecoder()){ response in
//                    switch response.result {
//                    case .success(let model):
////                        if response.response?.statusCode == 200{ // success
////                            guard model != nil else {return}
//                            promise(.success(model))
////                        }else if response.response?.statusCode == 400  { // bad request
////                            guard model != nil else {return}
////                            promise(.failure(NetworkError.badRequest(code: 400, error: "bad req")))
//
////                        }else if response.response?.statusCode == 401 {
//////                            guard model != nil else {return}
////                            promise(.failure(NetworkError.unauthorized(code: 401, error: "token needed")))
////                        }
//                    case .failure(let error):
////                        if response.response?.statusCode == 401 {  //Unauthorized
//                        promise(.failure(NetworkError.unknown(code: 0, error: error.localizedDescription)))
////                        }else{
////                        }
//                    }
//                }
        }
        .eraseToAnyPublisher()
    }

    static func request<M:Codable>(Target:T,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])

        AF.request(Target.url, method: method ,parameters: parameters.0, encoding: parameters.1, headers: headers)
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")

                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )
//print(model)
                        }else{
                            completion(false, nil, "serialization error" )
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print(err)
                        }
                    }
            })
    }
    
//    static func multipartRequest<M:Codable>(Target:T,image:UIImage? = nil,imageName:String?,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
//        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
//        let parameters = buildparameters(paramaters: Target.parameter)
//        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key , value) in parameters.0{
//
//                if let temp = value as? String {
//                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? Int {
//                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
//                }
//                if let temp = value as? NSArray{
//                    temp.forEach({ element in
//                        let keyObj = key + "[]"
//                        if let string = element as? String {
//                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
//                        } else
//                        if let num = element as? Int {
//                            let value = "\(num)"
//                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
//                        }
//                    })
//                }
//            }
//
////            if let image = image {
////                    let imageData = image.jpegData(compressionQuality: 1.0)!
////                    let imageName = "image.jpg"
////                parameters["profileImage"] = imageData
////            }
//
//            if let data = image?.jpegData(compressionQuality: 0.8), (image?.size.width ?? 0) > 0 {
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: imageName ?? "" , fileName: "file.jpeg", mimeType: "image/jpeg")
//                }else{
//                    print("cant get image data")
////                    completion(false, nil,"imageError")
//                }
//        },     to: Target.url,
//                  method: method,
//                  headers: headers
//        )
//
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
////                print(response.response?.statusCode)
////                print(response.result)
//
//                switch response.result{
//                    case .success(let model):
//                        if response.response?.statusCode == 200{ // success
//                            guard model != nil else {return}
//                            completion(true, model , "success")
//
//                        }else if response.response?.statusCode == 400  { // bad request
//                            guard model != nil else {return}
//                        completion(false,model,"Bad Request" )
//
//                        }else{
//                            completion(false, nil, "serialization error" )
//                        }
//
//                    case .failure(let err):
//                        if response.response?.statusCode == 401 {  //Unauthorized
//                            completion(false, nil, "Unauthorized")
//
//                        }else{
//                            completion(false, nil, err.localizedDescription)
//                            print(err)
//                        }
//                    }
//            })
//    }
    
     static func buildparameters(paramaters:parameterType)->([String:Any],ParameterEncoding){
        switch paramaters{
        case .plainRequest:
            return ([:],URLEncoding.default)
        case .parameterRequest(Parameters: let Parameters, Encoding: let Encoding):
            return(Parameters,Encoding)
        }
    }
    
    }
public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badURL(let errorMsg):
            return NSLocalizedString("Bad Url", comment: errorMsg)
        case .invalidJSON(let errorMsg):
            return NSLocalizedString("00", comment: errorMsg)
        case .unauthorized(let code, let errorMsg):
            return NSLocalizedString("\(code)", comment: errorMsg)
        case .unknown(let code, let errorMsg):
            return NSLocalizedString("\(code)", comment: errorMsg)
        default:
            return NSLocalizedString("Unknown Error", comment: "Unknown")
        }
    }
}
