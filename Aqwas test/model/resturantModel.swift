//
//  File.swift
//  Aqwas test
//
//  Created by 2p on 5/17/20.
//

import Foundation
import UIKit
import EVReflection
//{
//    "error": "no",
//    "name": "coffee valley (وادي القهوة)",
//    "id": "57c6ebaf498e35841d656d24",
//    "link": "https://foursquare.com/v/57c6ebaf498e35841d656d24",
//    "cat": "Coffee Shop",
//    "catId": "4bf58dd8d48988d1e0931735",
//    "rating": "8.2",
//    "lat": "26.250245232397",
//    "lon": "50.202616887374",
//    "Ulat": "50.2017993",
//    "Ulon": "26.2716025",
//    "open": "",
//    "image": [
//        "https://fastly.4sqi.net/img/general/250x250/533597249_sb97kRGz0-oPacc6nmbaKECZi9fexRO-FF6CEKon4kY.jpg"
//    ]
//}
class resturantModel: EVObject {
    var error: String? = nil
    var name: String? = nil
    var link: String? = nil
    var cat: String? = nil
    var catId: String? = nil
    var rating: String? = nil
    var lat: String? = nil
    var lon: String? = nil
    var Ulat: String? = nil
    var Ulon: String? = nil
    var open: String? = nil
    var image: [String]? = nil
}
