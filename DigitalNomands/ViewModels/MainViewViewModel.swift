//
//  MainViewViewModel.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import Combine
import Network
import Foundation

final class MainViewViewModel: ObservableObject {
    struct State {
        var articles: [Article?] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
    
    private let defaults = UserDefaults.standard
    @Published private(set) var state = State()
    @Published private(set) var status: NWPath.Status = .satisfied
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        NWPathMonitor()
            .publisher()
            .map { $0.status }
            .assign(to: &$status)
    }
    
    func fetchNextPageIfPossible() {
        guard status == .satisfied else { return }
        guard state.canLoadNextPage else { return }
        NewsAPI.searchRepos(page: state.page)
            .sink(receiveCompletion: onReceive, receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }
    
    private func onReceive(_ batch: [Article]) {
        state.articles += batch
        state.page += 1
        state.canLoadNextPage = state.page <= NewsAPI.maxPage
    }
}
