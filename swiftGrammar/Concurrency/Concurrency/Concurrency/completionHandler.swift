//
//  completionHandler.swift
//  Concurrency
//
//  Created by KyungHeon Lee on 2023/08/28.
//

import Foundation

// completionHandlerFunction
func completionHandlerFunction(completion: @escaping (Int?) -> Void) {
    var cnt:Int = 0
    DispatchQueue.global().async {
        // 비동기 작업을 수행하는 부분
        // 숫자 카운트
        cnt += 1

        DispatchQueue.main.async {
            completion(cnt)
        }
    }
}



