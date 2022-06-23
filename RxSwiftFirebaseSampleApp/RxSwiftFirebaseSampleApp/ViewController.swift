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
    
    @IBOutlet weak var statuesLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    // MARK: - 変数

    private var viewModel = ViewModel()
    private var viewModel2 = ViewModel2()
    private var viewModel3 = ViewModel3()
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()
        
//        registerButton.isHidden = true
        
        bind2()
        
        bind3()

    }
    

    
    // MARK: - 関数


    func bind() {
        let input = ViewModel.Input(
            emailText: emailTextField.rx.text.orEmpty.asDriver(),
            passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
            nameText: nameTextField.rx.text.orEmpty.asDriver(),
            tapRegisterButton: registerButton.rx.tap.asSignal(),
            tapRegisterButton2: registerButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
//        output.result.asObservable().bind(to: loginPasswordfield.rx.text)
//        output.x.emit().disposed(by: disposeBag)
        
//        output.isEnableSinin.drive().disposed(by: disposeBag)
        
//        output.result.drive().disposed(by: disposeBag)
        output.result
            .map { [weak self] result in
                print("##")
                if result {
                    let dialog = UIAlertController(title: "新規登録成功", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .cancel)
                    dialog.addAction(action)
                    
                    self?.present(dialog, animated: true)
                    
                }
            }
            .drive()
            .disposed(by: disposeBag)
        
        output.isEnableSinin
            .map { [weak self] bool in
                if bool {
                    print(1)
                    self?.registerButton.isEnabled = true
//                    self?.registerButton.isHidden = false
                } else {
                    print(2)
                    self?.registerButton.isEnabled = false
//                    self?.registerButton.isHidden = true
                }
            }
            .drive()
            .disposed(by: disposeBag)
        
//        output.result.drive(output.isEnableSinin)
        
    }
    
    func bind2() {
        let input = ViewModel2.Input2(
            loginEmailText: loginEmailTextField.rx.text.orEmpty.asDriver(),
            loginPasswordText: loginPasswordfield.rx.text.orEmpty.asDriver(),
            tappedLoginButton: loginButton.rx.tap.asSignal()
        )
        
        let output = viewModel2.transform(input: input)
        
        output.isEnableLogin
            .map { [weak self] bool in
                if bool {
                    self?.loginButton.isEnabled = true
                } else {
                    self?.loginButton.isEnabled = false
                }
            }
            .drive()
            .disposed(by: disposeBag)
        
        output.result
//            .debug("result: \(result)")
            .map { [weak self] result in
                print("result: \(result)")
                if result {
                    let dialog = UIAlertController(title: "ログイン成功", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "good", style: .cancel)
                    dialog.addAction(action)
                    
                    self?.present(dialog, animated: true)
                    
                }
            }
            .drive()
            .disposed(by: disposeBag)
    }
    
    func bind3() {
        let input = ViewModel3.Input3(tappedButton: loginButton.rx.tap.asSignal())
        
        let output = viewModel3.transform(input: input)
        
        output.loginBool
            .map { [weak self] bool in
                if bool {
                    self?.statuesLabel.text = "ログイン"
                } else {
                    self?.statuesLabel.text = "ログアウト"
                }
            }
            .drive()
            .disposed(by: disposeBag)
        
        output.nameString
            .drive(userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func tapButtonAction(_ sender: Any) {

    }
}

