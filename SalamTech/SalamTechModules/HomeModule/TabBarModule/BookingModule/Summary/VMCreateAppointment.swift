//
//  VMCreateAppointment.swift
//  SalamTech
//
//  Created by wecancity on 25/04/2022.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class VMCreateAppointment: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let GetModelCreateAppointment = PassthroughSubject<ModelCreateAppointment , Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    

   
    // ------- input

    @Published var PatientId                            :Int = 3305
    @Published var DoctorWorkingDayTimeId              :Int = 2
    @Published var AppointmentDate                       :String = ""
    @Published var Fees                      : Double = 0.0
    @Published var Comment                      : String = ""



    


    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedCreateAppointment: Statusmodel?



    @Published var isLoading:Bool?
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    init() {
   
        GetModelCreateAppointment.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            
            self.publishedCreateAppointment = modeldata.data
        
  
        }.store(in: &cancellables)
    
        
        
        
    }
        
    
    func CreatePatientAppointment() {
        let Parameters : [String:Any] = [
        // required
            "PatientId": PatientId ,
            "DoctorWorkingDayTimeId":DoctorWorkingDayTimeId,
            "AppointmentDate":AppointmentDate ,
            "Fees":Fees,
            "Comment":Comment
    ]
      
        
        
        if Helper.isConnectedToNetwork(){
            CreatePtAppointmentApi.CreateAppointment(parameters: Parameters,
        completion:  { (success, model, err) in
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.GetModelCreateAppointment.send(model!)
                    self.isLoading = false
                    self.isDone = true
                    print(model!)
                    self.errorMsg = model?.message ?? "success"

                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.message ?? "")
                self.errorMsg = err ?? "cannot get Doctors"
            }
        })
            self.isLoading = false

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
 
}
