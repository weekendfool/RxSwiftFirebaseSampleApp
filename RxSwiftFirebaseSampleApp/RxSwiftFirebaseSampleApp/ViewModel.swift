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
    var upTextFieldText: PublishRelay<String> { get }
    var downTextFieldText: PublishRelay<String> { get }
}

protocol ViewModelOutput {
    var outputText: Signal<String> { get }
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
    var upTextFieldText = PublishRelay<String>()
    var downTextFieldText =  PublishRelay<String>()
    
    // MARK: - output
    var outputText: Signal<String>
    
    init() {
        // output
        
        outputText = returnText.map { text in
            String(text)
        }
        .asSignal(onErrorSignalWith: .empty())
        
        
        // input
        isSetButtonTapped.map { [weak self] in
            self?.model.doSetting(text: self?.uptext)
            
//            return (self?.model.returnText)!
        }
        // 何も購読していないから縛らないし購読破棄も不必要
//        .bind(to: returnText)
//        .disposed(by: disposeBag)
        
        isAddButtonTapped.map { [weak self] in
            self?.model.doAdding(text: self?.dowtext)
        }
        
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
    }
    
    
}
