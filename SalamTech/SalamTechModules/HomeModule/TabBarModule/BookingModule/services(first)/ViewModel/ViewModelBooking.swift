//
//  ViewModelBooking.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation

import Combine

class ViewModelGetDoctorDashboard: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelDashboard, Error>()
//    let updatedpassthroughModelSubject = PassthroughSubject<ModelUpdateProfile, Error>()
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
    @Published  var TotalAppointmentCount: Int?
    @Published  var UpComingAppointmentCount: Int?
    @Published  var TodayAppointmentCount: Int?
    @Published  var MedicalTypeCount: Int?
    @Published  var MedicalTypeName : String = ""
    
    
//    @Published  var SubSpecialityId: [Int] = []
//    @Published  var DoctorInfo : String = ""
//    @Published  var DoctorInfoAr : String = ""
////
//
//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
    @Published var publishedDoctorModel: DoctorDashboard?
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var UserUpdated = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

 
    init() {
        startFetchDoctorDashboard()
//        startFetchDoctorProfile()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: {[self] (modeldata) in
            self.publishedDoctorModel = modeldata.data
            self.TotalAppointmentCount = publishedDoctorModel?.totalAppointmentCount ?? 0
            self.UpComingAppointmentCount = publishedDoctorModel?.upcomingAppointmentCount ?? 0
            self.TodayAppointmentCount = publishedDoctorModel?.todayAppointmentCount ?? 0
            self.MedicalTypeCount = publishedDoctorModel?.getMedicalExaminationDots?[0].medicalTypeCount ?? 0
            self.MedicalTypeName = publishedDoctorModel?.getMedicalExaminationDots?[0].medicalTypeName ?? ""
            
            
//            self.DoctorInfo = publishedDoctorModel?.doctorInfo ?? ""
//            self.DoctorInfoAr = publishedDoctorModel?.doctorInfoAr ?? ""
//            self.SubSpecialityName = publishedDoctorModel?.subspecialistName ?? []
//            self.SubSpecialityId = publishedDoctorModel?.subspecialistId ?? []
            print(self.publishedDoctorModel ?? "")
//            print(self.publishedClinicModel[0].id ?? "" )
            
        }.store(in: &cancellables)
        
        //-----------------------------------------------------------------
        //        passthroughSubject
        //            .dropFirst(2)
        //            .filter({ (value) -> Bool in
        //                value != "5"
        //            })
        //            .map { value in
        //                return value + " seconds"
        //            }
        //            .sink { (completion) in
        //                switch completion {
        //                case .finished:
        //                    self.time = "Finished"
        //                case .failure(let err):
        //                    self.time = err.localizedDescription
        //                }
        //            } receiveValue: { (value) in
        //                self.time = value
        //            }
        //            .store(in: &cancellables)
        //
        //-------------------------------------------------------
        
    }
    
//    func startUpdatingDoctorInfo() {
//        self.isLoading = true
//
//
//        let parametersarr : [String : Any]  = [
//
//                        "DoctorInfo" : DoctorInfo                ,
//                        "DoctorInfoAr" : DoctorInfoAr ,
//                        "DoctorSubSpecialist" : SubSpecialityId                    ,
//
//                        ]
//
//        if Helper.isConnectedToNetwork(){
////        if isValid == true {
//
//            GetDoctorProfileApiService.UpdateDoctorInfo(passedparameters: parametersarr,completion: { (success, model, err) in
//               self.isLoading = true
//            if success{
//                DispatchQueue.main.async {
//                    self.updatedpassthroughModelSubject.send(model!)
//                    self.isDone = true
//                    self.isLoading = false
//                    self.isError = true
//                    self.UserUpdated = true
//                    self.errorMsg = "updated "
//
//                }
//            }else{
//                self.isLoading = false
//                self.isError = true
//                print(model?.message ?? "")
//                self.errorMsg = err ?? "Profile image is empty"
//            }
//                print(err ?? "error from edit doc clinic / bad request ")
//                print(model?.message ?? "request message from edit clinic info")
//        })
//            self.isLoading = false
//
////        }else{
////            print("not validated")
////        }
//        }else{
//                   // Alert with no internet connection
//            self.isLoading = false
//          isNetworkError = true
//               }
//    }
    
  
    
    func startFetchDoctorDashboard() {

        if Helper.isConnectedToNetwork(){
      
            BookingApiService.GetDoctorDashboard(completion: { (success, model, err) in
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(model!)
                    self.isDone = true
                    self.isLoading = false
//                    print(model!)
                }
            }else{
                if model != nil {
                self.isLoading = false
                self.isError = true
                print(model?.message ?? "")
                self.errorMsg = err ?? "cannot get countries"
                  }else{
                    if err == "unauthorized"{
                        self.SessionExpired = true
                        self.isLoading = false

                    }
                }
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}


