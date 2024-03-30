//
//  SettingsViewController.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 27.03.24.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    private let cellID = "UITableViewCell"
    private let viewModel: SettingsViewViewModelType = SettingsViewViewModel()
    private var dataSource: UITableViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigurations()
        configureAppearance()
        configure()
    }
    
    func configure() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.settings.map({ $0.title }))
        dataSource.apply(snapshot)
    }
    
    private func setDiffableDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { [unowned self] tableView, indexPath, itemTitle in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            var content = cell?.defaultContentConfiguration()
            content?.text = itemTitle
            cell?.contentConfiguration = content
            return cell
        })
    }
}

extension SettingsViewController {
    
    private func setConfigurations() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setDiffableDataSource()
    }
    
    private func configureAppearance() {
        title = Resources.Strings.TabBar.settingsItem
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let (title, description) = viewModel.getInfoForSetting(at: indexPath)
        present(SettingViewController(title: title, description: description), animated: true)
    }
}
