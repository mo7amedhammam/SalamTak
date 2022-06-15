//
//  BaseNetwork.swift
//  SalamTak
//
//  Created by wecancity on 01/06/2022.
//

import Foundation
import Alamofire

final class BaseNetwork<T:TargetType>{

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
    
    static func multipartRequest<M:Codable>(Target:T,image:UIImage?,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key , value) in parameters.0{
                
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
                if let data = image?.jpegData(compressionQuality: 0.8), image != nil {
                    //be carefull and put file name in withName parmeter
                    multipartFormData.append(data, withName: "profileImage" , fileName: "file.jpeg", mimeType: "image/jpeg")
                }else{
                    print("cant get image data")
                    completion(false, nil,"imageError")
                }
            
        },     to: Target.url,
                  method: method,
                  headers: headers
        )
                
        
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )

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
    
    static func buildparameters(paramaters:parameterType)->([String:Any],ParameterEncoding){
        switch paramaters{
        case .plainRequest:
            return ([:],URLEncoding.default)
        case .parameterRequest(Parameters: let Parameters, Encoding: let Encoding):
            return(Parameters,Encoding)
        }
    }
    
    }
