//
//  ViewModel3.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/24.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModel3Type {
    associatedtype Input3
    associatedtype Output3
    
    func transform(input: Input3) -> Output3
}


class ViewModel3 {
    private let disposeBag: DisposeBag = DisposeBag()
    private let model: Model = Model()
}

extension ViewModel3: ViewModel3Type {
    
    struct Input3 {
        let tappedButton: Signal<Void>
    }
    
    struct Output3 {
        let loginBool: Driver<Bool>
        let nameString: Driver<String>
    }
    
    func transform(input: Input3) -> Output3 {
        
        let loginBool = input.tappedButton.asObservable()
            .map { _ -> Observable<Bool> in
                return self.model.searchLogin()
            }
            .merge()
            .asDriver(onErrorDriveWith: .empty())
        
        let nameString = input.tappedButton.asObservable()
            .map { _ -> Observable<String> in
                return self.model.searchUserName()
            }
            .merge()
            .asDriver(onErrorDriveWith: .empty())
        
        return Output3(loginBool: loginBool, nameString: nameString)
    }
    
}
