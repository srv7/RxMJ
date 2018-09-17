//
//  ViewModelType.swift
//  RxMJ_Example
//
//  Created by liubo on 2018/9/17.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
