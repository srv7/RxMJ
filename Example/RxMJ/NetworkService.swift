//
//  NetworkService.swift
//  RxMJ_Example
//
//  Created by liubo on 2018/9/17.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func getRandomResult(_ count: Int = 20) -> Observable<[String]> {
        return Observable<[String]>.create { (observer) -> Disposable in
            print("正在请求数据......")
            let items = (0..<count).map { (_) in
                "随机数据\(Int(arc4random()))"
            }
            print("请求数据成功")
            
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
        .delay(.seconds(2), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
        .observe(on: MainScheduler.instance)
    }
}

