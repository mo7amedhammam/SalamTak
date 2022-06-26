//
//  TargetType.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 01/06/2022.
//

import Foundation
import Alamofire

enum httpMethod:String{
    case Get = "Get"
    case Post = "POST"
    case Delete = "DELETE"
}
enum parameterType{
    case plainRequest
    case parameterRequest(Parameters:[String:Any],Encoding:ParameterEncoding)
}

protocol TargetType{
    var url : String {get}
    var method : httpMethod {get}
    var parameter : parameterType {get}
    var header : [String:String]? {get}
}
