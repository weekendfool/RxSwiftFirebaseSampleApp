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
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var realtimeSwich: UISwitch!
    @IBOutlet weak var upTextField: UITextField!
    @IBOutlet weak var downTextField: UITextField!
    @IBOutlet weak var sampleTableView: UITableView!
    
    // MARK: - 変数
    let db = Firestore.firestore()
    var queriedDataArray = [String()]
    
    var listener: ListenerRegistration?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sampleTableView.delegate = self
        sampleTableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    // MARK: - 関数


    func bind() {
        
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queriedDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sampleTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = queriedDataArray[indexPath.row]
        
        return cell
    }
    
    
}

