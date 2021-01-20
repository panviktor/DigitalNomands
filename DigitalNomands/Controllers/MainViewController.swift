//
//  MainViewController.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import UIKit
import Combine

final class MainViewController: UITableViewController {
    private var viewModel = MainViewViewModel()
    private var dataSource: [Article?] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.prefetchDataSource = self
        title = "Digital Nomands"
        setupColorSchema()
        viewModel.fetchNextPageIfPossible()
        binding()
    }
    
    private func binding() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.dataSource = items.articles
                self.title = "\(items.page - 1) of 5"
                self.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.$status
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status  {
                case .satisfied:
                    break
                case .unsatisfied:
                    //FIXME: - add element and button
                    self.tableView.reloadData()
                case .requiresConnection:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &subscriptions)
    }
}

//MARK: - DataSource & Delegate
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseID, for: indexPath) as! ArticleCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = dataSource[indexPath.row]?.url  ?? ""
        let detailVC = WKWebViewController(url: url)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    
  }
}

//MARK: - GUI
extension MainViewController {
    private func setupColorSchema() {
        view.backgroundColor = .mainWhite
        navigationController?.navigationBar.barTintColor = .mainWhite
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: - SwiftUI
import SwiftUI
struct MainViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainViewController()
        
        func makeUIViewController(context: Context) -> MainViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {}
    }
}

