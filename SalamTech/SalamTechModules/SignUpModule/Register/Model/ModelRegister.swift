//
//  ModelRegister.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation

//--------------------------------------

struct ModelRegister : Codable {
    var Data : userData?
    var MessageCode : Int?
    var Success : Bool?
    var Message : String?
    
    
}

struct userData : Codable{
    var Code : Int?
    var ReSendCounter : Int?
    var UserId : Int?
}

//---------------------------------------
