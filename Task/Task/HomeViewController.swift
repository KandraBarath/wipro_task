//
//  HomeViewController.swift
//  Task
//
//  Created by apple on 29/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    private let viewModel = HomeViewModel()
    private var results: [Row] = []
    
    /// Refresh control for UITableView
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func loadView(){
        super.loadView()
        setUpTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableview()
        getServiceData()
    }
    
    /// Setup method for TableView by programatically
    func updateTableview(){
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
            self.tableView.backgroundColor = .systemBackground
            
        } else {
            // Fallback on earlier versions
            self.view.backgroundColor = .white
            
        }
    }
    
    /// Adding constraint programatically for UITableView
    func setUpTableView(){
        let safeGuide = self.view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        tableView.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl){
        getServiceData(true)
    }

    /// Get data from  given service url
    /// - Parameter isFromRefresh: used to show loading indicator or not using the parameter
    func getServiceData(_ isFromRefresh: Bool = false){
        if !isFromRefresh {
            self.startLoading()
        }
        viewModel.getCanadaDetails { results in
            isFromRefresh ? self.refreshControl.endRefreshing() : self.stopLoading()
            switch results {
            case .success(let data):
                self.title = data.title
                self.results = data.rows
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        cell.item = self.results[indexPath.row]
        return cell
    }
}
