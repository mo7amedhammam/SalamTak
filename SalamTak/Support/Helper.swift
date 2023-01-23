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
    var patientName = ""
    var Image = ""
    var CurrentLatitude = ""
    var CurrentLongtude = ""
    var CurrentAddress = ""
    var currentLanguage = ""

    private static let languageKey = "language"
    private static let onBoardKey = "onBoard"
    private static let logedinKey = "logedin"
    
    class func setUserData(
        Id : Int,
        PhoneNumber : String,
        patientName : String
    ){
        userDef.set(  Id             , forKey:  "Id" )
        userDef.set(  PhoneNumber         , forKey: "PhoneNumber"  )
        userDef.set(  patientName         , forKey: "patientName"  )

        userDef.synchronize()
    }
    
    static func languageIsSet() {
        UserDefaults.standard.set(true, forKey: languageKey)
    }

    static func checkLanguageSet() -> Bool {
        return UserDefaults.standard.bool(forKey: languageKey)
    }
    
    static func onBoardOpened() {
        UserDefaults.standard.set(true, forKey: onBoardKey)
    }

    static func checkOnBoard() -> Bool {
        return UserDefaults.standard.bool(forKey: onBoardKey)
    }
    static func userLogedIn(value:Bool) {
        UserDefaults.standard.set(value, forKey: logedinKey)
    }

    static func checkIfLogedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: logedinKey)
    }
    
    
    
    //for checking if user exist
    class func userExist()->Bool{
        return userDef.string(forKey: "Id") != nil
    }
    
    class func getUserID() ->Int {
        return userDef.integer(forKey: "Id")
    }
    
    class func getUserPhone() ->String {
        return userDef.string(forKey: "PhoneNumber") ?? ""
    }
    class func getpatientName() ->String {
        return userDef.string(forKey: "patientName") ?? ""
    }
    
    class func setUserimage(userImage : String) {
        userDef.set(userImage, forKey: "Image")
        userDef.synchronize()
    }
    class func getUserimage() ->String {
        return userDef.string(forKey: "Image") ?? ""
    }
    
        class func setClinicId(clinicId: Int) {
        userDef.set(clinicId, forKey: "clinicId")
        userDef.synchronize()
    }
        class func getClinicId()->Int{
        return userDef.integer(forKey: "clinicId")
    }
    class func setLanguage(currentLanguage: String) {
    userDef.set(currentLanguage, forKey: "languageKey")
    userDef.synchronize()
    }
    class func getLanguage()->String{
    return userDef.string(forKey: "languageKey") ?? "en"
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
        userDef.removeObject(forKey:"patientName"  )
        userDef.removeObject(forKey:"Image"  )
        userDef.removeObject(forKey:"access_token"  )
        userDef.removeObject(forKey: "clinicId")
        userLogedIn(value: false)
        
        if let window = UIApplication.shared.windows.first {
              window.rootViewController = UIHostingController(rootView: WelcomeScreenView())
              window.endEditing(true)
              window.makeKeyAndVisible()
          }
    }
    class func changeLang() {
        userDef.removeObject(forKey:"languageKey"  )
       
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
        return userDef.string(forKey: "CurrentAddress") ?? "address"
    }
    //remove data then logout
    class func removeUserLocation() {
        userDef.removeObject(forKey:"CurrentLatitude"  )
        userDef.removeObject(forKey:"CurrentLongtude"  )
        userDef.removeObject(forKey:"CurrentAddress"  )
    }
    
    
    // navigate to google maps with lond & lat
    class func openGoogleMap(longitude: Double, latitude: Double) {
        let appURL = NSURL(string: "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving")!
        let webURL = NSURL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
            print(appURL)
        } else {
            // if GoogleMaps app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
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
    
    // Starting Phone call
    class func MakePhoneCall(PhoneNumber:String){
        let phone = "tel://"
        let phoneFormatted = phone + PhoneNumber
        guard let url = URL(string: phoneFormatted) else {return}
        UIApplication.shared.open(url)

    }
        
}

func ChangeFormate( NewFormat:String) -> DateFormatter {

    let df = DateFormatter()
    df.dateFormat = NewFormat
    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}

// change Format From String to String
func ConvertStringDate(inp:String, FormatFrom:String, FormatTo:String) -> String {
    var newdate = ""
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = FormatFrom
    if let date = formatter.date(from: inp) {
//        print(date)
        formatter.dateFormat = FormatTo
        newdate = formatter.string(from: date)
    }
 return newdate
  }

// change Format From date to date
func ConvertDateFormat(inp:Date, FormatTo:String) -> Date {
    var newdate = Date()
        let formatter = DateFormatter()
    let date = formatter.string(from: inp )
    formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = FormatTo
        newdate = formatter.date(from: date) ?? Date()
    
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



//extension UIDevice {
    var hasNotch: Bool
    {
        if #available(iOS 11.0, *)
        {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else
        {
            // Fallback on earlier versions
            return false
        }
    }
//}
