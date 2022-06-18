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
    }
    
}

