//
//  Observable.swift
//  Qiyas
//
//  Created by Macbook on 7/8/19.
//  Copyright © 2019 mohamed salah. All rights reserved.
//

import Foundation

class Observable<T> {

     var value: T {
         didSet {
            DispatchQueue.main.async {
               self.valueChanged?(self.value)
            }
         }
     }

     private var valueChanged: ((T) -> Void)?

     init(_ value: T) {
         self.value = value
     }

     /// Add closure as an observer and trigger the closure imeediately if fireNow = true
     func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
         valueChanged = onChange
         if fireNow {
             onChange?(value)
         }
     }

     func removeObserver() {
          valueChanged = nil
     }

}
