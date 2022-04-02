//
//  Helper.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//


import Foundation
import SystemConfiguration
import UIKit
import SwiftUI


final class Helper{
    static let userDef = UserDefaults.standard
    
    var Id           = 0
    var clinicId     = 0
    var PhoneNumber = ""
    var Image = ""
    var CurrentLatitude = ""
    var CurrentLongtude = ""
    var CurrentAddress = ""
    var currentLanguage = ""

    
    class func setUserData(
        Id : Int,
        PhoneNumber : String
        
    ){
        
//        userDef.set(clinicId, forKey: "clinicId")
        userDef.set(  Id             , forKey:  "Id" )
        userDef.set(  PhoneNumber         , forKey: "PhoneNumber"  )
        userDef.synchronize()
        //        restartApp()
    }
    
    
    //for checking if user exist
    class func userExist()->Bool{
        return userDef.string(forKey: "Id") != nil
    }
    
    class func getUserID() ->Int {
        return userDef.integer(forKey: "Id")
    }
    
    class func getUserPhone() ->String {
        return userDef.string(forKey: "PhoneNumber") ?? "default phone number"
    }
    
    class func setUserimage(userImage : String) {
        userDef.set(userImage, forKey: "Image")
        userDef.synchronize()
    }
    class func getUserimage() ->String {
        return userDef.string(forKey: "Image") ?? "default Image"
    }
    
        class func setClinicId(clinicId: Int) {
        userDef.set(clinicId, forKey: "clinicId")
        userDef.synchronize()
    }
        class func getClinicId()->Int{
        return userDef.integer(forKey: "clinicId")
    }
    class func setLanguage(currentLanguage: String) {
    userDef.set(currentLanguage, forKey: "currentLanguage")
    userDef.synchronize()
    }
    class func getLanguage()->String{
    return userDef.string(forKey: "currentLanguage") ?? "en"
    }
    
    //save access token
    class func setAccessToken(access_token : String) {
        userDef.set(access_token, forKey: "access_token")
        userDef.synchronize()
    }

    class func getAccessToken()->String{
        return userDef.string(forKey: "access_token") ?? "token default"
    }
    //remove data then logout
    class func logout() {
        userDef.removeObject(forKey:"Id"  )
        userDef.removeObject(forKey:"PhoneNumber"  )
        userDef.removeObject(forKey:"Image"  )
        userDef.removeObject(forKey:"access_token"  )
        userDef.removeObject(forKey: "clinicId")
    }
    class func changeLang() {
        userDef.removeObject(forKey:"currentLanguage"  )
       
    }
    

    class func setUserLocation(
                CurrentLatitude : String,
                CurrentLongtude : String
    ){
        userDef.set(          CurrentLatitude             , forKey:  "CurrentLatitude" )
        userDef.set(                  CurrentLongtude         , forKey: "CurrentLongtude"  )
        userDef.synchronize()
    }
    class func setUseraddress(
        CurrentAddress : String
    ){
        userDef.set(          CurrentAddress             , forKey:  "CurrentAddress" )
        userDef.synchronize()
    }
    class func getUserLatitude() ->String {
        return userDef.string(forKey: "CurrentLatitude") ?? "default CurrentLatitude"
    }
    
    class func getUserLongtude() ->String {
        return userDef.string(forKey: "CurrentLongtude") ?? "default CurrentLongtude"
    }
    class func getUserAddress() ->String {
        return userDef.string(forKey: "CurrentAddress") ?? "default CurrentAddress"
    }
    //remove data then logout
    class func removeUserLocation() {
        userDef.removeObject(forKey:"CurrentLatitude"  )
        userDef.removeObject(forKey:"CurrentLongtude"  )
        userDef.removeObject(forKey:"CurrentAddress"  )

   
    }
    
    
    // Checking internet connection
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
    
    class func MakePhoneCall(PhoneNumber:String){
        
        let phone = "tel://"
        let phoneFormatted = phone + PhoneNumber
        guard let url = URL(string: phoneFormatted) else {return}
        UIApplication.shared.open(url)

    }
        
}
public var datef:DateFormatter{
    let df = DateFormatter()
//    df.dateFormat = "yyyy/MM/dd"
//    df.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
    df.dateFormat = "dd/MM/yyyy"

    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}

public var timef:DateFormatter{
    let df = DateFormatter()
//    df.dateFormat = "yyyy/MM/dd"
    df.dateFormat = "HH:mm"
    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}

public var Fulldatef:DateFormatter{
    let df = DateFormatter()
//    df.dateFormat = "yyyy/MM/dd"
    df.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
//    df.dateFormat = "MM/dd/yyyy"

    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}
public var Fulldatef1:DateFormatter{
    let df = DateFormatter()
//    df.dateFormat = "yyyy/MM/dd"
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//    df.dateFormat = "MM/dd/yyyy"

    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}
public var Filterdatef:DateFormatter{
    let df = DateFormatter()
//    df.dateFormat = "yyyy/MM/dd"
    df.dateFormat = "yyyy-MM-dd"
//    df.dateFormat = "MM/dd/yyyy"

    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}


func TimeStringToDate(time: String) -> Date {
    var newdate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
    if let newDate = dateFormatter.date(from: time) {
    print(newDate)
newdate = newDate
    } else{
           print(" can't convert ")
        }
    return newdate
//        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
//    print(dateFormatter.string(from: newDate))
//        return dateFormatter.string(from: newDate)
}

func formatStringDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy'T'HH:mm:ss"
    guard let newDate = dateFormatter.date(from: date) else { return "" }
    print(newDate)
//    return newDate
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
    print(dateFormatter.string(from: newDate))
        return dateFormatter.string(from: newDate)
}


func getDateString(inp:String) -> String {
    var newdate = ""
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    if let date = formatter.date(from: inp) {
//        print(date)
        formatter.dateFormat = "dd/MM/yyyy"
        newdate = formatter.string(from: date)
    }
 return newdate
  }
func getTimeString(inp:String) -> String {
    var newdate = ""
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    if let date = formatter.date(from: inp) {
//        print(date)
        formatter.dateFormat = "HH:MM a"
        newdate = formatter.string(from: date)
    }
 return newdate
  }

func getEMRTimeString(inp:String) -> String {
    var newdate = ""
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    if let date = formatter.date(from: inp) {
//        print(date)
        formatter.dateFormat = "HH:MM a"
        newdate = formatter.string(from: date)
    }
 return newdate
  }
func getEMRDateString(inp:String) -> String {
    var newdate = ""
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    if let date = formatter.date(from: inp) {
//        print(date)
        formatter.dateFormat = "dd/MM/yyyy"
        newdate = formatter.string(from: date)
    }
 return newdate
  }

func LogoType(MedicalExaminationTypeId: Int) -> String {
    var logoname = ""
    if MedicalExaminationTypeId == 1 {  logoname = "mappin"}
    else if MedicalExaminationTypeId == 2 { logoname = "mappin"}
    else if MedicalExaminationTypeId == 3 { logoname = "video"}
    else if MedicalExaminationTypeId == 4 { logoname = "phone.fill"}
    else if MedicalExaminationTypeId == 5 { logoname = "bubble.left"}

    return logoname
}


//extension Binding where Value == Int {
//    public func string() -> Binding<String> {
//        return Binding<String>(get:{ String(self.wrappedValue) },
//            set: { self.wrappedValue = String($0)})
//    }
//}
//extension Binding where Value == Int {
//    public func string() -> Binding<String> {
//        return Binding<String>(get:{ "\(self.wrappedValue)" },
//                               set: {
//                                guard $0.count > 0 else { return }
//            self.wrappedValue = Int(Double($0) ?? 0)
//                               })
//    }
//}


//func GetExaminationValueByTypeId(typeId:Int, sourcearr:[Duration])->Int {
//
//    var value = 0
////        ForEach(self.publishedModelExaminationTypeId , id:\.id){ item in
//    for item in sourcearr{
//        if typeId == item.id {
//            value = item.duration ?? 01212
//        }
//    }
//    return value
//}



