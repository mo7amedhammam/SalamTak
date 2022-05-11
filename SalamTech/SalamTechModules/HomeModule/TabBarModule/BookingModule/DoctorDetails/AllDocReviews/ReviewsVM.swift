//
//  ReviewsVM.swift
//  SalamTech
//
//  Created by wecancity on 11/05/2022.
//

import Foundation
import Combine

class ReviewsVM: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ReviewsModel, Error>()
    private var cancellables: Set<AnyCancellable> = []
  
    
    @Published var doctorId: Int?

//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
    @Published var publishedReviewsModel: [DocReview]? = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var IsDone = false
    @Published var isNetworkError = false
 
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedReviewsModel = modeldata.data ?? []
            print("self.publishedAreaModel VM ")

            print(self.publishedReviewsModel ?? [])
//            print(self.publishedAreaModel?[0].Name ?? "" )
            
        }.store(in: &cancellables)
   
    }
    
    func startFetchReviews() {

        if Helper.isConnectedToNetwork(){
            ReviewsApi.GetDocReviews(doctorId: doctorId ?? 0
                                        , completion:  { (success, model, err) in
            
                    self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(model!)
                    self.IsDone = true
                    self.isLoading = false
//                    print("model! API ")
//
//                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
//                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get areas"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}
