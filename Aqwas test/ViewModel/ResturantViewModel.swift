//
//  File.swift
//  Aqwas test
//
//  Created by 2p on 5/17/20.
//

import Foundation
//
//  File.swift
//  Swipe
//
//  Created by 2p on 9/1/19.
//  Copyright © 2019 2p. All rights reserved.
//

import Foundation
import UIKit

class ResturantViewModel {
    
    var resturantResult: Observable<resturantModel?>
//    var error: Observable<ErrorModel?>
    var requestType: String?
    var contentType: String?
    var accept: String?
    
    init(requestType: String, contentType: String, accept: String){
        self.contentType = contentType
        self.requestType = requestType
        self.accept = accept
        resturantResult = Observable(resturantModel())
//        error = Observable(ErrorModel())
    }
    
    func startTheCall(_parameters : [String : Any],  urlString:String)
    {
        
        if (try? JSONSerialization.data(
            withJSONObject: _parameters,
            options: [])) != nil {
            let comm = NetworkCommunication()
//            var url = "https://wainnakel.com/api/v1/GenerateFS.php?"
            print(urlString)
//            var headerbody = ["uid":"26.2716025,50.2017993","get_param":"value"]
            comm.getJsonResponseAsString(urlString, requestType: self.requestType!, contentType: self.contentType!, accept: self.accept!, data: nil, headerbody: [:], token: nil, success: { (dic) in
                print(dic)
              
                    let str = "{\"resp\":\(dic)}"
                    let result = returantResponse(json: str)
                    DispatchQueue.main.async {
                        print(result.resp as Any)
                        self.resturantResult.value = result.resp
                    }
                
              
                
            }) { (err) in
                print(err)
            }
        }
    }
    
}
