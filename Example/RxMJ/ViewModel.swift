//
//  ViewModel.swift
//  RxMJ_Example
//
//  Created by liubo on 2018/9/17.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import RxMJ
import RxSwift
import RxCocoa

class ViewModel: ViewModelType {
    let disposedBag = DisposeBag()
    
    func transform(_ input: ViewModel.Input) -> ViewModel.Output {
        let header = input
            .headerRefresh
            .flatMapLatest { NetworkService.shared.getRandomResult(20).catchAndReturn([]) }
            .share(replay: 1)
        
        let footer = input
            .footerRefresh
            .flatMapLatest { NetworkService.shared.getRandomResult(19).catchAndReturn([]) }
            .share(replay: 1)
        
        let endHeader = header.map { _ in false }
            .asDriver(onErrorJustReturn: false)
        let endFooter = Observable.merge(header.map(footerState), footer.map(footerState))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
        
        let tableData = BehaviorRelay<[String]>(value: [])
        header.bind(to: tableData).disposed(by: disposedBag)
        footer.map { tableData.value + $0 }.bind(to: tableData).disposed(by: disposedBag)
        let output = Output(endHeaderRefresh: endHeader, endFooterRefresh: endFooter, tableData: tableData)
        return output
    }
}

extension ViewModel {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
}

extension ViewModel {
    struct Output {
        let endHeaderRefresh: Driver<Bool>
        let endFooterRefresh: Driver<RxMJRefreshFooterState>
        let tableData: BehaviorRelay<[String]>
    }
}

extension ViewModel {
    func footerState(_ items: [String]) -> RxMJRefreshFooterState {
        return items.count < 20 ? .noMoreData : .default
    }
}
