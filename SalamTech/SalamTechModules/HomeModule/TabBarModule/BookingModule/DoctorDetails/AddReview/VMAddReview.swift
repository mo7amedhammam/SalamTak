//
//  VMAddReview.swift
//  SalamTech
//
//  Created by wecancity on 18/05/2022.
//

import Foundation
import Combine
import Alamofire


class VMAddReview: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelFetchDoctors = PassthroughSubject<MAddReview , Error>()

    private var cancellables: Set<AnyCancellable> = []
    // ------- input

    @Published var DoctorId                    :Int = 0
    @Published var Rate                         :Int = 0
    @Published var Comment                      :String = ""


    @Published var publishedModelAddReview : rateSt?



    @Published var isLoading:Bool?
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    init() {
        
        ModelFetchDoctors.sink { (completion) in
            //            print(completion)
        } receiveValue: { [weak self]  (modeldata) in
            
            self?.publishedModelAddReview = modeldata.data
        
  
        }.store(in: &cancellables)
        
        
    }
        
    
    func AddDocRate() {
        let Parameters : [String:Any] = [
        // required
            "DoctorId": DoctorId ,
            "Rate":Rate,
            "Comment":Comment
        ]
        
        if Helper.isConnectedToNetwork(){
            print(Parameters)
            
            ApiAddReview.AddDoctorRate(parameters: Parameters,
        completion:  { (success, model, err) in

                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.ModelFetchDoctors.send(model!)
                    self.isLoading = false
                    self.errorMsg = model?.message ?? ""
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

