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
    
    func login(email: String, pass: String) -> Observable<Bool> {
        return Observable.create { observer in
            Auth.auth().signIn(withEmail: email, password: pass) { (result , error) in
                print("##")
                if let user = result?.user {
                    print("ログイン完了")
                    observer.onNext(true)
                } else if let error = error {
                    print("ログイン失敗")
                    observer.onNext(false)
                }
            }
            return Disposables.create()
        }
    }
    
    func searchUserName() -> Observable<String> {
        return Observable.create { observer in
            if let user = Auth.auth().currentUser {
                Firestore.firestore().collection("users").document(user.uid).getDocument { (snapshot, error) in
                    if let snap = snapshot {
                        if let data = snap.data() {
                            let name = data["name"] as! String
                            observer.onNext(name)
                        }
                    } else if let error = error {
                        print("ユーザー名取得失敗")
                        observer.onNext("取得失敗")
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func searchLogin() -> Observable<Bool> {
        return Observable.create { observer in
            if let user = Auth.auth().currentUser {
                print("ログイン中")
                observer.onNext(true)
            } else {
                print("ログインしてないよ")
                observer.onNext(false)
            }
            return Disposables.create()
        }
    }
    
    func logout() -> Observable<Bool> {
        
        return Observable.create { observer in
            if Auth.auth().currentUser != nil {
                // ログアウト処理
                do {
                    try Auth.auth().signOut()
                    print("ログアウト完了")
                    observer.onNext(true)
                } catch let error as NSError {
                    print("ログアウト")
                    observer.onNext(false)
                }
            }
            return Disposables.create()
        }
    }
    
    
    
}
