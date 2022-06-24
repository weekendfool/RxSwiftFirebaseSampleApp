//
//  ViewModel4.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/24.
//

import Foundation
import RxSwift
import RxCocoa


protocol ViewModel4Type {
    associatedtype Input4
    associatedtype Output4
    
    func transform(input: Input4) -> Output4
}


class ViewModel4 {
    private let disposeBag: DisposeBag = DisposeBag()
    private let model: Model = Model()
}

extension ViewModel4: ViewModel4Type {
   
    struct Input4 {
        let tapLogoutButton: Signal<Void>
    }
    
    struct Output4 {
        let isLogoutEnabled: Driver<Bool>
    }
    
    func transform(input: Input4) -> Output4 {
        
        let isLogoutEnabled = input.tapLogoutButton.asObservable()
            .map { _ -> Observable<Bool> in
                return self.model.logout()
            }
            .merge()
            .asDriver(onErrorDriveWith: .empty())
        
        return Output4(isLogoutEnabled: isLogoutEnabled)
    }
    
    
    

}
