//
//  ViewModel2.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    
}

extension ViewModel: ViewModelType {
    
    struct Input {
        let emailText: Driver<String>
        let passwordText: Driver<String>
        let nameText: Driver<String>
        
        let tapRegisterButton: Signal<Void>
    }
    
    struct Output {
        let resultText: Driver<String>
        
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output(resultText: <#T##Observable<String>#>)
    }
}
