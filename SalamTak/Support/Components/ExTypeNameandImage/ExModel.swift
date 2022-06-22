//
//  ExModel.swift
//  SalamTech
//
//  Created by wecancity on 15/05/2022.
//

import Foundation
struct ExModel  {
        var name: String?
        var image: String?
        var Comment: String?

}


func getEx(id:Int) -> ExModel{
    let id = id
    var modelFil = ExModel()
    
    switch id{
    case 1:
        modelFil.name = "Clinic "
        modelFil.image = "building"
        
        
    case 2:
        modelFil.name = "Home visit"
        modelFil.image = "house"
        
    case 3:
        modelFil.name = "Video "
        modelFil.image = "video.bubble.left"
        
    case 4:
        modelFil.name = "Call "
        modelFil.image = "phone.bubble.left"
        modelFil.Comment = "Doctor will call you on time"
        
    default:
        modelFil.name = "Chat "
        modelFil.image = "ellipsis.bubble"
        
    }
    
    return modelFil
}
