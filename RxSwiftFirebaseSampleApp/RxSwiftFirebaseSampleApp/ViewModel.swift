//
//  ViewModel2.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/08.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

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
        let result: Driver<Bool>
        
        
    }
    
    func transform(input: Input) -> Output {
        
        let result = Driver<Bool>.zip(input.emailText, input.passwordText, input.nameText) { email, password, name in
            
            // MARK: - model化する
            var resultBool: Bool = false
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    print("ユーザー登録完了 uid: \(user.uid) ")
                    Firestore.firestore().collection("users").document(user.uid).setData([
                        "name": name
                    ]) { error in
                        if let error = error {
                            print("==============================")
                            print("ユーザー登録失敗")
                            
                            resultBool = false
                        } else {
                            print("----------------------------------------")
                            print("ユーザー作成完了")
                            
                            resultBool = true
                        }
                    }
                } else if let error = error {
                    print("===============================")
                    print("新規登録失敗")
                    
                    resultBool = false
                }
            }
            
            return resultBool
        }
        
        return Output(result: result)
    }
}
