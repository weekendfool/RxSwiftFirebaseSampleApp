//
//  ViewModel2.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/22.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase
import FirebaseAuth

protocol ViewModel2Type {
    associatedtype Input2
    associatedtype Output2
    
    func transform(input: Input2) -> Output2
}

class ViewModel2 {
    private let disposeBag: DisposeBag = DisposeBag()
}


extension ViewModel2: ViewModel2Type {
    
    struct Input2 {
        let loginEmailText: Driver<String>
        let loginPasswordText: Driver<String>
        let tappedLoginButton: Signal<Void>
    }
    
    struct Output2 {
        let result: Driver<Bool>
        let isEnableLogin: Driver<Bool>
    }
    
    func transform(input: Input2) -> Output2 {
        // emaiとpassの一時保存
        var email: String = ""
        var password: String = ""
        
        let isEnableLogin = Driver<Bool>.combineLatest(input.loginEmailText, input.loginPasswordText) { emailText, passwordText in
            if emailText != "" && passwordText != "" {
                email = emailText
                password = passwordText
                
                return true
            } else {
                return false
            }
        }
        
        
        let result = input.tappedLoginButton.map { _ -> Bool in
//            var bool = false
            Auth.auth().signIn(withEmail: email, password: password) { (result , error) in
                print("##")
                if let user = result?.user {
                    print("ログイン完了")
//                    return true
                } else if let error = error {
                    print("ログイン失敗")
//                    return false
                }
//                return true
            }
//            print("bool: \(bool)")
            return true
        }.asDriver(onErrorDriveWith: .empty())
        
        return Output2(result: result, isEnableLogin: isEnableLogin)
    }
    
}


