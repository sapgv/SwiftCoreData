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
        
        self.fetchController.reloadActionDelegate = self
        
    }
    
    private func setupViewModel() {
        
        self.viewModel.refreshListCompletion = { [weak self] error in
            
            self?.log(error)
            
        }
        
        self.viewModel.cleanListCompletion = { [weak self] error in
            
            self?.log(error)
            
        }
        
        self.viewModel.newPersonCompletion = { [weak self] error in
            
            self?.log(error)
            
        }
        
        self.viewModel.deletePersonCompletion = { [weak self] error in
            
            self?.log(error)
            
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

//MARK: - FetchControllerReloadDelegate

extension PersonListViewController: FetchControllerReloadActionDelegate {
    
    func handle(actions: [FetchControllerReloadAction]) {
        
        self.tableView.handle(actions: actions)
        
        self.scrollToUpdatedCell(actions: actions)
        
    }
    
    private func scrollToUpdatedCell(actions: [FetchControllerReloadAction]) {
        
        print(actions)
        
        let indexPath = actions
            .compactMap { action in
                switch action {
                case let .insertRows(array):
                    return array
                case let .moveRows(_, indexPath):
                    return [indexPath]
                case let .updateRows(array):
                    return array
                default:
                    return nil
                }
            }
            .flatMap { $0 }
            .last
        
        guard let indexPath else { return }
        
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
            cell.animateBackgroundColor(.green.withAlphaComponent(0.3))
        }
                
    }
    
}

//MARK: - Log

extension PersonListViewController {
    
    private func log(_ error: Error?) {
        guard let error = error else { return }
        print(error.localizedDescription)
    }
    
}
