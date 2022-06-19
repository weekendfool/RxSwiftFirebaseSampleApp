//
//  ViewController.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/02.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {

    
    // MARK: - ui
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    // MARK: - 変数

    private var viewModel = ViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()

    }
    

    
    // MARK: - 関数


    func bind() {
        let input = ViewModel.Input(
            emailText: emailTextField.rx.text.orEmpty.asDriver(),
            passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
            nameText: nameTextField.rx.text.orEmpty.asDriver(),
            tapRegisterButton: registerButton.rx.tap.asSignal()
        )
        
        let output = viewModel.transform(input: input)
        
//        output.result.asObservable().bind(to: loginPasswordfield.rx.text)
        output.x.emit().disposed(by: disposeBag)

    }
    
    @IBAction func tapButtonAction(_ sender: Any) {
//        Auth.auth().createUser(withEmail: "tokutai.sei.5102@gmail.com", password: "password3") { result, error in
//            if let user = result?.user {
//                print("ユーザー登録完了3 uid: \(user.uid) ")
//                Firestore.firestore().collection("users").document(user.uid).setData([
//                    "name": "dare"
//                ]) { error in
//                    if let error = error {
//                        print("==============================")
//                        print("ユーザー登録失敗3")
//
////                            resultBool = false
//                    } else {
//                        print("----------------------------------------")
//                        print("ユーザー作成完了3")
//
////                            resultBool = true
//                    }
//                }
//            } else if let error = error {
//                print("===============================")
//                print("新規登録失敗3")
//
////                    resultBool = false
//            }
//
//        }
    }
}

