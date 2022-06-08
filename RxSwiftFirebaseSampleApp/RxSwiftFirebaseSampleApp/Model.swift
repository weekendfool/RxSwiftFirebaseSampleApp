//
//  Model.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/03.
//

import Foundation
import Firebase
import FirebaseFirestore


class Model {
    
    let db = Firestore.firestore()
    
    var queriedDataArray = [String()]
    var returnText: String = ""
    
    var listener: ListenerRegistration?
    
    func doSetting(text: String?) {
        guard let text = text else { return }
        
        db.collection("sample").document("test").setData(
            [
                "text": text
            ]) { error in
                if let error = error {
                    print("ドキュメントの書き込みに失敗")
                } else {
                    print("ドキュメントの書き込みに成功しました")
                }
            }
    }
    
    func doAdding(text: String?) {
        var ref: DocumentReference? = nil
        guard let text = text else { return }
        ref = db.collection("sample").addDocument(data:[
            "text": text
        ]) { error in
            if let error = error {
                print("ドキュメントの追加に失敗")
            } else {
                print("ドキュメントの追加に成功しました")
            }
        }
    }
    
    func doGetting() -> String {
        db.collection("sample").getDocuments { querySnapshot, error in
            if let error = error {
                print("ドキュメントの取得に失敗しました")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    if let text = data["text"] as? String {
                    self.queriedDataArray.append(text)
                    
                    self.returnText = text
                        
                    }
                }
//                return self.returnText
            }
//            return self.returnText
        }
        return self.returnText
    }
    
    func onRealtimeUpdata() -> String {
        listener = db.collection("smple").addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("ドキュメントの取得に失敗しました：レアルタイムアップデート")
            } else {
                self.queriedDataArray = []
                if let documentSnapshot = documentSnapshot?.documents {
                    for document in documentSnapshot {
                        let data = document.data()
                        if let text = data["text"] as? String {
                            self.queriedDataArray.append(text)
                            
                            self.returnText = text
                        }
                    }
                }
            }
        }
        return returnText
    }
    
    
    func offRealtimeUpdata() {
        listener?.remove()
    }
    
    
    
    
}

