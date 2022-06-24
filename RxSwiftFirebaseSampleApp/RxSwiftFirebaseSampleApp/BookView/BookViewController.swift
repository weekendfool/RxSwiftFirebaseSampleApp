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
    
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 関数

    
    

}
