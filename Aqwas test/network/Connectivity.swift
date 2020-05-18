//
//  File.swift
//  Qiyas
//
//  Created by 2p on 7/24/19.
//  Copyright © 2019 mohamed salah. All rights reserved.
//

import Alamofire

class Connectivity {
class func isConnectedToInternet() -> Bool {
return NetworkReachabilityManager()?.isReachable ?? false
}
}
