//
//  Model.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/03.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import RxSwift
import RxCocoa

//tokutai.sei.5102@gmail.com


class Model {
    
    func signinFirebase(email: String, pass: String, name: String) -> Observable<Bool> {
//        var bool = false
        
        return Observable.create { observer in
            Auth.auth().createUser(withEmail: email, password: pass) { result, error in
                if let user = result?.user {
                    print("ユーザー登録完了 uid: \(user.uid) ")
                    Firestore.firestore().collection("users").document(user.uid).setData([
                        "name": name
                    ]) { error in
                        if let error = error {
                            print("==============================")
                            print("ユーザー登録失敗")
                            observer.onNext(false)
                        } else {
                            print("----------------------------------------")
                            print("ユーザー作成完了")
                            observer.onNext(true)
                        }
                    }
                } else if let error = error {
                    print("===============================")
                    print("新規登録失敗")
                    observer.onNext(false)
                }
            }
            return Disposables.create()
        }
        
    }
    
//    func signinFirebase2(email: Driver<String>, pass: Driver<String>, name: Driver<String>) -> Bool {
//        Auth.auth().createUser(withEmail: email, password: pass) { result, error in
//            if let user = result?.user {
//                print("ユーザー登録完了2 uid: \(user.uid) ")
//                Firestore.firestore().collection("users").document(user.uid).setData([
//                    "name": name
//                ]) { error in
//                    if let error = error {
//                        print("==============================")
//                        print("ユーザー登録失敗2")
//                        bool = false
//                    } else {
//                        print("----------------------------------------")
//                        print("ユーザー作成完了2")
//                        bool = true
//                    }
//                }
//            } else if let error = error {
//                print("===============================")
//                print("新規登録失敗2")
//                bool =
//            }
//        }
//        return bool
//    }
}
