//
//  BookViewModel.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/25.
//

import Foundation
import RxCocoa
import RxSwift


protocol BookViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class BookViewModel {
    private let disposebag: DisposeBag = DisposeBag()
    private let model: Model = Model()
}

extension BookViewModel: BookViewModelType {
    
    
    struct Input {
        let tappedAddButton: Signal<Void>
        let title: Driver<String>
    }
    
    struct Output {
        let result: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        var title: String = ""
        input.title.map { text in
            title = text
        }
        
        let result = input.tappedAddButton.asObservable()
            .map { _ -> Observable<Bool> in
                return self.model.addData(title: title)
            }.merge()
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(result: result)
    }
}
