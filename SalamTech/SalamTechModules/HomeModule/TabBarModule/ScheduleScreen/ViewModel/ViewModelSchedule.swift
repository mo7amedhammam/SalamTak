//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelGetAppointmentInfo: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelGetSubject = PassthroughSubject<ModelGetSchedule, Error>()
    let passCancelModel = PassthroughSubject<ModelCancelAppointment, Error>()

    private var cancellables: Set<AnyCancellable> = []
 
    @Published var exmodelId  = 0
    
    @Published var showcncel = false
    @Published var AppointmentCancelID  = 0
    @Published var AppointmentCancelReason  = ""
    
    @Published var publishedCancelModel: ModelCancelAppointment?

    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedDoctorCreatedModel: [AppointmentInfo] = []
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var iscancelled = false

    @Published var isNetworkError = false
    @Published var noschedules = false

    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    
    
    
    init() {
        

        
        passthroughModelGetSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            noschedules = false
            self.publishedDoctorCreatedModel = modeldata.data ?? []
            if publishedDoctorCreatedModel.count == 0 || publishedDoctorCreatedModel == [] {
                noschedules = true
            }
        }.store(in: &cancellables)
        
        passCancelModel.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedCancelModel = modeldata
            print(self.publishedCancelModel!)
            print(self.publishedCancelModel?.data?.Statues ?? false )
            
        }.store(in: &cancellables)

        
    }
    
    func startFetchAppointmentInfo() {
                    self.isLoading = true

        if Helper.isConnectedToNetwork(){

            
            ScheduleApiService.GetPatientAppointmentInfo(medicalExaminationTypeId:exmodelId,
                completion:  { (success, model, err) in
            if success{
                DispatchQueue.main.async {
//                    self.UserCreated = true
                    self.errorMsg = model?.message ?? ""
                    self.isLoading = false
                    self.passthroughModelGetSubject.send(model!)
                    print(model!)
                }
            }else{
                self.isAlert = true
                self.activeAlert = .serverError
                
                self.isLoading = false
//                self.UserCreated = true
                print(model?.message ?? "")
                self.errorMsg = err ?? ""
            }
        })

        }else{
                   // Alert with no internet connection
            self.isAlert = true
            self.activeAlert = .NetworkError
            
//            self.isLoading = false
          isNetworkError = true
               }
    }
    
    func startFetchCancelAppointment() {
        self.isLoading = true

        if Helper.isConnectedToNetwork(){
       
            ScheduleApiService.CanselAppointment(AppointmentId: AppointmentCancelID , CancelReason: AppointmentCancelReason,
                completion: { (success, model, err) in
            if success == true{
                DispatchQueue.main.async {
                    self.errorMsg = model?.message ?? ""
                    self.isLoading = false
                    self.passCancelModel.send(model!)
                    print(self.iscancelled)
                    
                    self.isAlert = true
                    self.activeAlert = .cancel
                }
            }else{
                self.isAlert = true
                self.activeAlert = .cancel
                self.isLoading = false

                self.errorMsg = err ?? "cannot get history appointment"
                print(self.errorMsg)
            }
        })

        }else{
                   // Alert with no internet connection
            self.isAlert = true
            self.activeAlert = .NetworkError
            self.isLoading = false
//          isNetworkError = true
               }
    }

}
