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
        let tappedGetButton: Signal<Void>
        let title: Driver<String>
    }
    
    struct Output {
        let result: Driver<Bool>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        var title: String = ""
        
        input.title.map { text in
            print("title: \(text)")
            title = text
        }.drive()
            .disposed(by: disposebag)
        
        let result = input.tappedAddButton.asObservable()
            .map { _ -> Observable<Bool> in
                return self.model.addData(title: title)
            }.merge()
            .asDriver(onErrorDriveWith: .empty())
        
        let text = input.tappedGetButton.asObservable()
            .map { _ -> Observable<String> in
                print("title1: \(title)")
                return self.model.getData(title: title)
            }
            .merge()
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(result: result, text: text)
    }
}
