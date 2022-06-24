//
//  BookViewController.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookViewController: UIViewController {
    

    // MARK: - ui
    @IBOutlet weak var sampleButton: UIButton!
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var sampleTableView: UITableView!
    @IBOutlet weak var sampleTextField: UITextField!
    
    // MARK: - 変数
    private let disposeBog: DisposeBag = DisposeBag()
    
    private let bookViewModel: BookViewModel = BookViewModel()
    
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bind()
    }
    
    // MARK: - 関数
    
    func bind() {
        let input = BookViewModel.Input(
            tappedAddButton: sampleButton.rx.tap.asSignal(),
            title: sampleTextField.rx.text.orEmpty.asDriver()
        )
        
        let output = bookViewModel.transform(input: input)
        
        output.result.map { [weak self] bool in
            if bool {
                self?.sampleLabel.text = "成功"
            } else {
                self?.sampleLabel.text = "失敗"
            }
        }
        .drive()
        .disposed(by: disposeBog)
    }

    
    

}
