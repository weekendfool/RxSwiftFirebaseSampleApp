//
//  ViewModel.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/03.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelInput {
    // buttonのインプット
    var isSetButtonTapped: PublishRelay<Void> { get }
    var isAddButtonTapped: PublishRelay<Void> { get }
    var isGetButtonTapped: PublishRelay<Void> { get }
    var isOnRealtimeSwich: PublishRelay<Bool> { get }
    // textFieldのインプット
    var upTextFieldText: Driver<String> { get }
    var downTextFieldText: Driver<String> { get }
}

protocol ViewModelOutput {
    var outputText: Observable<String> { get }
}

protocol ViewModelType {
    var input: ViewModelInput { get }
    var output: ViewModelOutput { get }
}

class ViewModel: ViewModelType, ViewModelInput, ViewModelOutput {
    
    var input: ViewModelInput { return self }
    var output: ViewModelOutput { return self }
    
    private var disposeBag = DisposeBag()
    
    // model
    private var model: Model = Model()
    
    private var returnText = BehaviorRelay<String>(value: "")
    
    private var uptext: String = ""
    private var dowtext: String = ""
    
    // MARK: - input
    var isSetButtonTapped = PublishRelay<Void>()
    var isAddButtonTapped = PublishRelay<Void>()
    var isGetButtonTapped = PublishRelay<Void>()
    var isOnRealtimeSwich =  PublishRelay<Bool>()
    var upTextFieldText = Driver<String>()
    var downTextFieldText =  Driver<String>()
    
    // MARK: - output
    var outputText: Observable<String>
    
    init() {
        // output
        
        outputText = returnText.map { text in
            String(text)
        }
        
        
        
        // input
        isSetButtonTapped.map { [weak self] in
            print("self?.uptext: \(self?.uptext)")
            self?.model.doSetting(text: self?.uptext)
            
            return (self?.model.returnText)!
        }
        .bind(to: returnText)
        .disposed(by: disposeBag)
        
        isAddButtonTapped.map { [weak self] in
            self?.model.doAdding(text: self?.dowtext)
            
            return (self?.model.returnText)!
        }
        .bind(to: returnText)
        .disposed(by: disposeBag)
        
        isGetButtonTapped.map { [weak self] in
            return (self?.model.doGetting())!
        }
        .bind(to: returnText)
        .disposed(by: disposeBag)
        
        isOnRealtimeSwich.map { [weak self] tap in
            if tap {
                return (self?.model.onRealtimeUpdata())!
            } else {
                self?.model.offRealtimeUpdata()
                return "offにしたよ"
            }
        }
        .bind(to: returnText)
        .disposed(by: disposeBag)
        
        
        upTextFieldText.map { [weak self] in
            self?.uptext = $0
            print("text:\($0)")
        }
        
        downTextFieldText.map { [weak self] text in
            self?.dowtext = text
        }
    }
    
    
}
