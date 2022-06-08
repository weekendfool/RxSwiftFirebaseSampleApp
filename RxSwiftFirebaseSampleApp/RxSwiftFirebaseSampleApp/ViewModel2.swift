//
//  ViewModel2.swift
//  RxSwiftFirebaseSampleApp
//
//  Created by Oh!ara on 2022/06/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel2 {
    
    typealias Input = (
        titleText: Driver<String>,
        tap: Signal<Void>
    )
    typealias Output = (
        label: Driver<String>,
        ()
    )
    
    var input
}
