//
//  Model2.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/08.
//

import Foundation
import FirebaseFirestore
import RxSwift

class StoreManager {
    
    static let shared = StoreManager()
    private let store = Firestore.firestore()
    
    func insertToFireStore(title: String, detail: String) {
        let data: [String: Any] = [
            "title": title,
            "detail": detail,
            "createdAt": Timestamp()
        ]
        
        store.collection("todos").addDocument(data: data)
    }
    
    // firestore からtodosのデータ取得
        func fetchTodosFromFirestore() -> Single<[TodoModel]> {
            Single.create { [weak self](single) -> Disposable in
                self?.store.collection("todos").getDocuments { (snapshots, error) in
                    guard let docs = snapshots?.documents, error == nil else {
                        single(.failure(CustomError.error(message: "Failed To Fetch Todos From Firestore")))
                        return
                    }
                    let todos = docs.map { TodoModel(data: $0.data()) }
                    single(.success(todos))
                }

                return Disposables.create()
            }
        }
}
