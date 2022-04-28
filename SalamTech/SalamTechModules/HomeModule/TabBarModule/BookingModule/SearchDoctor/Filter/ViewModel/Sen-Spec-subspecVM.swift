//
//  Sen-Spec-subspecVM.swift
//  SalamTech
//
//  Created by wecancity on 28/04/2022.
//

import Foundation
import Combine

class ViewModelSeniorityLevel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelSeniorityLevel, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
//    @Published  var FirstName : String = ""
//    @Published  var FirstNameAr: String = ""
//    @Published  var MiddelName: String = ""
//    @Published  var MiddelNameAr: String = ""
//    @Published  var LastName: String = ""
//    @Published  var LastNameAr: String = ""
//    @Published  var GenderId: Int = 0
//    @Published  var SpecialistId: Int = 0
//    @Published  var Birthday: String = ""     //  date format "yyyy/mm/dd"
//    @Published  var SeniorityLevelId: Int = 0
//    @Published  var Website : String? = ""
//    @Published  var DoctorInfo : String? = ""
//    @Published  var DoctorInfoAr : String? = ""
//    @Published  var NationalityId: Int = 0
//    @Published  var DoctorSubSpecialist : [Int]? = []
//    @Published  var profileImage : UIImage? = nil
//
//
//
//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
    @Published private(set) var  publishedSeniorityLevelModel: [seniority] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
 
    init() {
        startFetchSenioritylevel()
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedSeniorityLevelModel = modeldata.Data ?? []
        }.store(in: &cancellables)

    }
    
    
  
    
    func startFetchSenioritylevel() {

        if Helper.isConnectedToNetwork(){
            ApiService.GetSeniorityLevel(completion:  { (success, model, err) in
                
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.UserCreated = true
                    self.isLoading = false
                    self.passthroughModelSubject.send(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get seniorityLevel"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}

class ViewModelSubSpecialist: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelSubSpecialist, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
//    @Published  var FirstName : String = ""
//    @Published  var FirstNameAr: String = ""
//    @Published  var MiddelName: String = ""
//    @Published  var MiddelNameAr: String = ""
//    @Published  var LastName: String = ""
//    @Published  var LastNameAr: String = ""
    @Published  var SpecialistId: Int = 0
//    @Published  var SpecialistId: Int = 0
//    @Published  var Birthday: String = ""     //  date format "yyyy/mm/dd"
//    @Published  var SeniorityLevelId: Int = 0
//    @Published  var Website : String? = ""
//    @Published  var DoctorInfo : String? = ""
//    @Published  var DoctorInfoAr : String? = ""
//    @Published  var NationalityId: Int = 0
//    @Published  var DoctorSubSpecialist : [Int]? = []
//    @Published  var profileImage : UIImage? = nil
//
//
//
//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
    @Published  var  publishedSubSpecialistModel: [subspeciality] = []
//    @Published var publishedSubarr: [subspec]?
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
 
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            
            self.publishedSubSpecialistModel = modeldata.Data ?? []
        }.store(in: &cancellables)
 
        
    }
    
    func startFetchSubSpecialist(id:Int) {

        if Helper.isConnectedToNetwork(){
            ApiService.GetSubSpecialist(SpecialistId: id, completion:  { (success, model, err) in
                
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.UserCreated = true
                    self.isLoading = false
                    self.passthroughModelSubject.send(model!)
//                        self.publishedSubarr = model!.Data
 
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get Sub Specialist"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}

