//
//  ViewModelDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 18/04/2022.
//


import Foundation
import Combine
import Alamofire
import SwiftUI

class ViewModelDocDetails: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let GetModelDocDetails = PassthroughSubject<ModelDocDetails , Error>()
//    let ModelSchedualByServiseDayId = PassthroughSubject<ModelGetSchedualByServiseDayId, Error>()
//    let ModelCreatedSchedual = PassthroughSubject<ModelCreateServiceById, Error>()
//    let ModelUpdatedSchedual = PassthroughSubject<ModelUpdatedClinicSchedual, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    

   
    // ------- input

    @Published var DoctorId                            :Int = 0
    @Published var MedicalExaminationTypeId              :Int = 0
    @Published var ClinicId                               :Int = 0
    @Published var SchedualDate                      : Date = Date()


    


    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedModelSearchDoc: DocDetails?



    @Published var isLoading:Bool?
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    init() {
   
        GetModelDocDetails.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            
            self.publishedModelSearchDoc = modeldata.data
        
  
        }.store(in: &cancellables)
    
        

        
        
        
    }
        
    
    func FetchDoctorDetails() {
        let Parameters : [String:Any] = [
        // required
            "DoctorId": DoctorId ,
            "MedicalExaminationTypeId":MedicalExaminationTypeId,
            "ClinicId":ClinicId ,
            "SchedualDate":Filterdatef.string(from: SchedualDate)
    ]
      
        
        
        if Helper.isConnectedToNetwork(){
            ApiDocDetails.DocDetails(parameters:Parameters,
        completion:  { (success, model, err) in
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.GetModelDocDetails.send(model!)
                    self.isLoading = false
                    self.isDone = true
                    print(model!)
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
