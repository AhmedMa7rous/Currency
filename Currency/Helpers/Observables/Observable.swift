//
//  Observable.swift
//  Currency
//
//  Created by Ahmed Mahrous on 18/08/2023.
//


import Foundation

class Observable<T> {
    
    //MARK: - Properties
    
    ///This value that we target changing of it.
    var value: T? {
        didSet {
            ///inside didSet it maybe happens in a various kind of the trees i prefer  to put it under the main thread
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    ///This listener is privatly live inside this class to change all thing and then update bind function
    private var listener: ((T?) -> Void)?
    
    
/*===========================================================*/
    //MARK: - LifeCycle
    
    init(_ value: T?) {
        self.value = value
    }

/*===========================================================*/
    //MARK: - Services Functions
    
    ///Binding Function
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
