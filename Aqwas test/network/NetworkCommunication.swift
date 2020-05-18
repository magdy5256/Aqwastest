//
//  NetworkCommunication.swift
//  Qiyas
//
//  Created by Macbook on 7/8/19.
//  Copyright © 2019 mohamed salah. All rights reserved.
//

import UIKit
import MobileCoreServices

class NetworkCommunication: NSObject {
    
    
    
    func GetDatafromURL(url: URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?,  _ error: Error?) -> Void))
    {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion (data , response, error)
        }.resume()
    }
    
    
    func getJsonResponseAsString(_ urlString:String, requestType:String, contentType:String, accept:String, data: Data?, headerbody:[String:Any],token:String?,
                                 success:@escaping ((_ result: String)-> Void), errorres:((_ err:Error)->Void))
    {
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            let url = URL(string: urlString)
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = requestType
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
            request.addValue(accept, forHTTPHeaderField: "Accept")
            //    request.a
            //    request.
            if requestType == "GET" || requestType == "DELETE" {
                //        request.addValue(token!, forHTTPHeaderField: "token")
                for i in headerbody{
                    print(i.value)
                    print(i.key)
                    request.addValue(i.value as! String, forHTTPHeaderField: i.key)
                }
                
            }
                
            else{
                if data != nil {
                    
                    request.httpBody = data
                }
            }
            
            if requestType != "GET" &&  requestType != "DELETE" {
                //if token != nil {
                for i in headerbody{
                    print(i.value)
                    print(i.key)
                    request.addValue(i.value as! String , forHTTPHeaderField: i.key)
                    //       }
                }
                
            }
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            let session = URLSession.shared
            session.dataTask(with: request as URLRequest)  { (datares, response, error) in
                
                if datares != nil
                {
                    if let httpResponse = response as? HTTPURLResponse {
                        if let headers = httpResponse.allHeaderFields as? [String: String]{
                            print(headers["Set-Cookie"] )
                            if let setOfCookie =  headers["Set-Cookie"] {
                                print(setOfCookie)
                                var cookie = setOfCookie.components(separatedBy: ";")
                                //                split(setOfCookie) {$0 == "="}
                                print(cookie[1])
                                var token = cookie[0].components(separatedBy: "=")
                                print(token[1])
                                let defaults = UserDefaults.standard
                                defaults.set(token[1], forKey: "Token")
                            }
                        }
                        
                        print(httpResponse.statusCode)
                        if httpResponse.statusCode == 200{
                            let res = NSString(data: datares!, encoding: String.Encoding.utf8.rawValue)
                            print(res)
                            success(String(res!))
                        }
                        else{
                            let res = NSString(data: datares!, encoding: String.Encoding.utf8.rawValue)
                            success(String(res!))
                        }
                    }
                    else
                    {
                        success(String(""))
                    }
                }
                else
                {
                    success("")
                }
                
            }.resume()
        }else{
            
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                    
                    
                    
                    DispatchQueue.main.async { [weak self] in
                        let alert = UIAlertController(title: "Internet Conection", message: "Check your Internet Connection and try again later", preferredStyle: UIAlertController.Style.alert)
                        
                        
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                            switch action.style{
                            case .default:
                                print("default")
                                
                                
                            case .cancel:
                                print("cancel")
                                
                            case .destructive:
                                print("destructive")
                                
                            }}))
                        //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        topController.present(alert, animated: true, completion: nil)
                        //Loading.getSingleton_instance()?.stopAnimation()
                        
                    }
                }
                
                
                // topController should now be your topmost view controller
            }
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                DispatchQueue.main.async { [weak self] in
                    let alert = UIAlertController(title: "Internet Conection", message: "Check your Internet Connection and try again later", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    topController.present(alert, animated: true, completion: nil)
                    //Loading.getSingleton_instance()?.stopAnimation()
                }
                
            }
            
        }
    }
}
