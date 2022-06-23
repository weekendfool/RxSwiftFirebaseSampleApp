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
    private let model = Model()
    
}

extension ViewModel: ViewModelType {
    
    struct Input {
        let emailText: Driver<String>
        let passwordText: Driver<String>
        let nameText: Driver<String>
        
        let tapRegisterButton: Signal<Void>
        let tapRegisterButton2: Driver<Void>
    }
    
    struct Output {
        let result: Driver<Bool>
//        let x: Signal<Bool>
        let isEnableSinin: Driver<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
//        let result: PublishSubject<Bool> = PublishSubject<Bool>()
        
        var name: String = ""
        var email: String = ""
        var password: String = ""
        
        //Observable<Observable<Bool>> を　Observable<Bool>に変更するために .merge() つける
        let result = input.tapRegisterButton.asObservable()
            .map { _ -> Observable<Bool> in
                return self.model.signinFirebase(email: email, pass: password, name: name)
            }
            .merge()
            .asDriver(onErrorDriveWith: .empty())
    

//        let x = self.model.signinFirebase(email: email, pass: password, name: name)
//
//        x.subscribe { data in
//
//            print("data: \(data)")
//        }
//
//
//
//
       
//        let result = input.tapRegisterButton.map { _ -> Bool in
//            var bool = false
//            Auth.auth().createUser(withEmail: email, password: password) { result, error in
//                if let user = result?.user {
//                    print("ユーザー登録完了2 uid: \(user.uid) ")
//                    Firestore.firestore().collection("users").document(user.uid).setData([
//                        "name": name
//                    ]) { error in
//                        if let error = error {
//                            print("==============================")
//                            print("ユーザー登録失敗2")
//                            bool = false
//                        } else {
//                            print("----------------------------------------")
//                            print("ユーザー作成完了2")
//                            bool = true
//                        }
//                    }
//                } else if let error = error {
//                    print("===============================")
//                    print("新規登録失敗2")
//                }
//            }
//            return bool
//        }.asDriver(onErrorDriveWith: .empty())
       
        let isEnableSinin = Driver<Bool>.combineLatest(input.emailText, input.passwordText, input.nameText) { emailText, passwordText, nameText in
            
            if emailText != "" && passwordText != "" && nameText != "" {
                print("-----------------------")
                print("true")
                
                email = emailText
                password = passwordText
                name = nameText
                
                print("email: \(email)")
                print("password: \(password)")
                print("name: \(name)")
                
                return true
            } else {
                print("=========================")
                print("false")
                return false
            }
        }
        

            
        return Output(result: result, isEnableSinin: isEnableSinin)

}
    
    
    }

