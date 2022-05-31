//
//  APIAddReview.swift
//  SalamTech
//
//  Created by wecancity on 18/05/2022.
//

import Foundation
import Alamofire

final class ApiAddReview{
    
    static func AddDoctorRate(parameters:[String:Any],completion: @escaping ( Bool , MAddReview?, String?) -> ()) {
        
        let url = URLs().DoctorSearch
        let header:HTTPHeaders = ["Content-Type":"application/json" ,"Authorization":Helper.getAccessToken()]
        let parameters : [String : Any] = parameters as [String : Any]
        print(parameters)
        
        AF.request(url, method: .post,parameters: parameters ,encoding: JSONEncoding.default ,headers: header )
            .validate(statusCode: 200...500)
            .responseDecodable(completionHandler: { ( response : DataResponse<MAddReview?, AFError>) in
                
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
                completion(false, model ,model?.message )
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










//try Generic model
struct PanpaResponse<T>: Codable where T: Codable {
    
    private var messageCode: Int?
    var msgCode: Status {
        if messageCode == 1 || messageCode == 0 {
            return .success
        }
        return .failed
    }
    
    private var messageString: String?
    var message: String {
        if let messageString = messageString {
            return messageString
        } else {
            return "error_generic"
        }
    }
    
    private var success: Bool?
    var st: Bool {
        if let success = success {
            return success
        } else {
            return false
        }
    }
    
    private(set) var data: T?
    
    enum CodingKeys: String, CodingKey {
        case messageCode = "MessageCode"
        case messageString = "Message"
        case data = "Data"
        case success = "Success"

    }
    
    init() {
        self.messageCode = -1
        self.messageString = "error_generic"
        self.data = nil
        self.success = false
    }
    
    enum Status {
        case success
        case failed
    }
    
}
