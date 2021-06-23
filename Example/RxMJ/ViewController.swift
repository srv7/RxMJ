//
//  ViewController.swift
//  RxMJ
//
//  Created by srv7 on 09/17/2018.
//  Copyright (c) 2018 srv7. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    lazy var bag: DisposeBag = {
        return DisposeBag()
    }()
    
    lazy var tableView: UITableView = {
        return UITableView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoStateFooter()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.mj_header?.beginRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindViewModel() {
        
        let input = ViewModel.Input(
            headerRefresh: tableView.mj_header!.rx.refreshing.asObservable(),
            footerRefresh: tableView.mj_footer!.rx.refreshing.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        output.endHeaderRefresh.drive(tableView.mj_header!.rx.isRefreshing).disposed(by: bag)
        output.endFooterRefresh.drive(tableView.mj_footer!.rx.refreshFooterState).disposed(by: bag)
        
        output.tableData.skip(1)
            .bind(to: tableView.rx.items) { table, row, element in
                let cell = table.dequeueReusableCell(withIdentifier: UITableViewCell.description())!
                cell.textLabel?.text = "\(row)、\(element)"
                return cell
            }
            .disposed(by: bag)
    }

}

