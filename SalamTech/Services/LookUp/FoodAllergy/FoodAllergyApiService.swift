
//

import Foundation
import Alamofire



final class GetFoodAllergyApiService{

static func GetFoodAllergy( completion: @escaping ( Bool , ModelFoodAllergy?, String?) -> ()) {
    
    let url = URLs().GetFoodAllergy
        let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
    
    AF.request(url, method: .get,parameters: nil ,encoding: JSONEncoding.default ,headers: header )
        .validate(statusCode: 200..<500)
        .responseDecodable(completionHandler: { ( response : DataResponse<ModelFoodAllergy?, AFError>) in
            switch response.response?.statusCode {
            case 200 : print("Success")
        ////////////////////////////////
            switch response.result {
                //--------------
            case .failure(let error):
                print(error.localizedDescription)
                completion(false, nil, error.localizedDescription)
                
            case .success(let model):
                guard model != nil else {return}
                if model?.Success == true {
                    completion(true, model , model?.Message ?? "")
                    
                } else{
                    print(model?.Message ?? "")
                    
                    completion(false, model, model?.Message ?? "")
                }
    
                //-------------

            }
     

        case 401 : print("The token expired (unauthorized)")
        case 400 : print("bad request")
                switch response.result {
                      //--------------
                  case .failure(let error):
                      print(error.localizedDescription)
                      completion(false, nil, error.localizedDescription)
                      
                  case .success(let model):
                      guard model != nil else {return}
                  completion(false, model , model?.Message)
  //                print(model?.message ?? "")
  //                    if model?.success == false{
  //
  //                        completion(true, model , model?.message)
  //                        print(model?.message ?? "")
  //                        print("clinic schedual created from api servise")
  //                        //                      Helper.setAccessToken(access_token: model?.Data?.token ?? "")
  //
  //                    } else{
  //                        completion(false, nil, model?.message)
  //                    }
                      //-------------
                  }
        default: return
        }
            ///////////////////////////
        })
    
}

    

}
