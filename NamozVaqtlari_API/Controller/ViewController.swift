//
//  ViewController.swift
//  NamozVaqtlari_API
//
//  Created by Abdulbosid Jalilov on 03/01/23.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {

    //MARK: - Text Field -
    
    let search: UITextField = {
       let search = UITextField()
        search.placeholder = " Search "
        search.layer.cornerRadius = 10
        search.layer.borderWidth = 1
        return search
    }()
    
    //MARK: - Table View -
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 160
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        
        //MARK: - Search -
        
        view.addSubview(search)
        search.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).multipliedBy(0.15)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
        //MARK: - Table View -
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom).offset(20)
            make.centerX.bottom.width.equalToSuperview()
            
        }

    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}

