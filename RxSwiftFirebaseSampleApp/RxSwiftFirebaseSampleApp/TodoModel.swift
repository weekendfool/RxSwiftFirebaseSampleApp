//
//  TodoModel.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/08.
//

import Foundation
import FirebaseFirestore

struct TodoModel {
    let title: String
    let detail: String
    let createdAt: Timestamp

    init(data: [String: Any]) {
        title = data["title"] as? String ?? ""
        detail = data["detail"] as? String ?? ""
        createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
    }
}

