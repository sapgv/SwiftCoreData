//
//  PersonListViewController.swift
//  SwiftCoreData
//
//  Created by sapgv on 12/29/2024.
//  Copyright (c) 2024 sapgv. All rights reserved.
//

import UIKit
import SwiftCoreData

class PersonListViewController: UIViewController {

    var viewModel: PersonListViewModel!
    
    private let tableView = UITableView()
    
    private lazy var fetchController = {
        let fetchController = FetchController(
            CDPerson.self,
            context: viewModel.viewContext,
            sortDescriptors: [NSSortDescriptor(keyPath: \CDPerson.age, ascending: true)],
            sectionNameKeyPath: "name",
            cacheName: nil
        )
        return fetchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Persons"
        self.view.backgroundColor = .white
        self.setupNavigationItems()
        self.setupFetchController()
        self.setupViewModel()
        self.setupTableView()
        self.layoutView()
        self.fetch()
    }

}

extension PersonListViewController {
    
    private func setupFetchController() {
        
        self.fetchController.reloadDelegate = self.tableView
        
    }
    
    private func setupViewModel() {
        
        self.viewModel.refreshListCompletion = { [weak self] error in
            
            self?.fetch()
            
        }
        
        self.viewModel.cleanListCompletion = { [weak self] error in
            
            self?.fetch()
            
        }
        
        self.viewModel.newPersonCompletion = { error in
            
            if let error {
                print(error.localizedDescription)
            }
            
        }
        
        self.viewModel.deletePersonCompletion = { error in
            
            if let error {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    private func setupTableView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: PersonCell.id, bundle: nil), forCellReuseIdentifier: PersonCell.id)
        
    }
    
    private func setupNavigationItems() {
        
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshList))
        
        let cleanButton = UIBarButtonItem(title: "Clean", style: .plain, target: self, action: #selector(cleanList))
        
        let newButton = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(newPerson))
        
        self.navigationItem.leftBarButtonItems = [refreshButton, cleanButton]
        
        self.navigationItem.rightBarButtonItems = [newButton]
        
    }
    
    private func layoutView() {
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
    }
    
}

extension PersonListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.fetchController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchController.sections else {
            return self.fetchController.fetchedObjects?.count ?? 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.id, for: indexPath) as? PersonCell else { return UITableViewCell() }
        let cdPerson = self.fetchController.object(at: indexPath)
        cell.setup(name: cdPerson.name, age: cdPerson.age.int)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = self.fetchController.sections else { return nil }
        return sections[section].name
    }
    
}

extension PersonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            
            let cdPerson = self.fetchController.object(at: indexPath)
            
            self.viewModel.deletePerson(cdPerson)
            
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
        
    }
    
}

extension PersonListViewController {
    
    private func fetch() {
        self.fetchController.performFetch()
        self.tableView.reloadData()
    }
    
}

//MARK: - Navigation items action

extension PersonListViewController {
    
    @objc
    private func refreshList() {
        
        self.viewModel.refreshList()
        
    }
    
    @objc
    private func cleanList() {
        
        self.viewModel.cleanList()
        
    }
    
    @objc
    private func newPerson() {
        
        self.viewModel.newPerson()
        
    }
    
}
