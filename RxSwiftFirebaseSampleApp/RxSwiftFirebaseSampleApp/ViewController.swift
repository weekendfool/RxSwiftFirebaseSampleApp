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
        
//        registerButton.isHidden = true

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
        
        output.result.drive().disposed(by: disposeBag)
        output.result
            .map { [weak self] result in
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
    
    @IBAction func tapButtonAction(_ sender: Any) {

    }
}

