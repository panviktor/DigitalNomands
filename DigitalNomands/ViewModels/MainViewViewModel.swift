//
//  MainViewViewModel.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import Combine
import Network
import Foundation

protocol ArticlesViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
}

final class MainViewViewModel: ObservableObject {
    private weak var delegate: ArticlesViewModelDelegate?
    private var isFetchInProgress = false
    struct State {
        var articles: [Article?] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
    
    private let defaults = UserDefaults.standard
    @Published private(set) var state = State()
    @Published private(set) var status: NWPath.Status = .satisfied
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(delegate: ArticlesViewModelDelegate) {
        NWPathMonitor()
            .publisher()
            .map { $0.status }
            .assign(to: &$status)
        self.delegate = delegate
    }
    
    func fetchNextPageIfPossible() {
        guard status == .satisfied else { return }
        guard state.canLoadNextPage else { return }
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        NewsAPI.searchRepos(page: state.page)
            .sink(receiveCompletion: onReceive, receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            self.isFetchInProgress = false
        case .failure:
            self.isFetchInProgress = false
            self.state.canLoadNextPage = false
        }
    }
    
    private func onReceive(_ batch: [Article]) {
        state.articles += batch
        state.page += 1
        state.canLoadNextPage = state.page <= NewsAPI.maxPage
        
        if state.page > 1 {
          let indexPathsToReload = self.calculateIndexPathsToReload(from: batch)
          self.delegate?.onFetchCompleted(with: indexPathsToReload)
        }
    }
    
    private func calculateIndexPathsToReload(from newArticles: [Article]) -> [IndexPath] {
        let startIndex = state.articles.count - newArticles.count
        let endIndex = startIndex + newArticles.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
