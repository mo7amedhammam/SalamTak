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
        modelFil.name = "Clinic"
        modelFil.image = "building"
        modelFil.Comment = "Book_Appointment_at_the_clinic"
        
    case 2:
        modelFil.name = "Home_visit"
        modelFil.image = "house"
        modelFil.Comment = "Doctor_will_visit_you_at_home"
        
    case 3:
        modelFil.name = "Video"
        modelFil.image = "video.bubble.left"
        modelFil.Comment = "Video_Chat_call_with_the_doctor"
        
    case 4:
        modelFil.name = "Call"
        modelFil.image = "phone.bubble.left"
        modelFil.Comment = "Doctor_will_call_you_on_time"
        
    default:
        modelFil.name = "Chat"
        modelFil.image = "ellipsis.bubble"
        modelFil.Comment = "text_chat_with_the_doctor"
        
    }
    
    return modelFil
}
