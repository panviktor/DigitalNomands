//
//  MainViewController.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import UIKit

final class MainViewController: UITableViewController {
    private var viewModel = MainViewViewModel()
    
    let moc: [Article] = [Article.mocArticle, Article.mocArticle, Article.mocArticle, Article.mocArticle, Article.mocArticle]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        setupColorSchema()
        viewModel.fetchNextPageIfPossible()
        binding()
    }
    
    private func binding() {
        self.navigationItem.title = String(viewModel.state.page)
    }
}

//MARK: - DataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moc.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseID, for: indexPath) as! ArticleCell
        cell.configure(with: moc[indexPath.row])
        return cell
    }
}

//MARK: - Delegate
extension MainViewController {

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

