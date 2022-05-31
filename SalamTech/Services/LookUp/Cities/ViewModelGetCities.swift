//
//  ViewModelGetCities.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 27/01/2022.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class ViewModelGetCities: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelCities, Error>()

    private var cancellables: Set<AnyCancellable> = []

    @Published var CountryId: Int = 1
    @Published var CityId: Int = 0
    
//    //------- output
    @Published var publishedCityModel: [City] = []
    
    @Published var isLoading:Bool? = false
    @Published var IsDone = false
 
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedCityModel = modeldata.Data ?? []
            print(self.publishedCityModel)
           // print(self.publishedCityModel[0].Name ?? "" )
        }.store(in: &cancellables)
        
        
    }

    func startFetchCities() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            let url = URLs().GetCities
            let header : HTTPHeaders = [:]
            let Parameters : [String:Any] = [:]
            
            let queryItems = [URLQueryItem(name:"CountryId",value:"\(CountryId)")]
            var urlComponents = URLComponents(string: url)
            urlComponents?.queryItems = queryItems
            let convertedUrl = urlComponents?.url
            if let convertUrl = convertedUrl {
                print(convertUrl)
            }
            
            NetworkLayer.request(url: "\(convertedUrl!)", method: .get, parameters: Parameters, header: header, model: ModelCities.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                    }
                    message = model?.Message ?? "Bad Request"

                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.Message ?? "Bad Request"
                        activeAlert = .serverError
                }
                    else{
                    //case of Empty model (unauthorized)
                        message = "Session_expired\nlogin_again".localized(language)
                    activeAlert = .unauthorized

                }
                    isAlert = true
                }
                isLoading = false
            }
            
        }else{
            //case of no internet connection
            activeAlert = .NetworkError
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
        }
        
    }
    
    
    
}


