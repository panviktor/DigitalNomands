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
        var articles: [Article] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
    
    private let defaults = UserDefaults.standard
    @Published private(set) var state = State() {
        didSet {
            print(state.articles.first)
        }
    }
    
    @Published private(set) var status: NWPath.Status = .satisfied
    
    private var downloadWasSuccessful: Bool {
        get {
            return defaults.object(forKey: "downloadWasSuccessful") as? Bool ?? false
        } set (newValue) {
            defaults.set(newValue, forKey: "downloadWasSuccessful")
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        NWPathMonitor()
            .publisher()
            .map { $0.status }
            .assign(to: &$status)
    }
    
    func fetchNextPageIfPossible() {
        guard status == .satisfied else {
            //FIXME: - Add system cache
            if downloadWasSuccessful {
                // downloading from cache
                print("downloading from cache")
            }
            // cache is empty
            print("cache is empty")
            return
        }
        guard state.canLoadNextPage else { return }
        NewsAPI.searchRepos(page: state.page)
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
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
        state.canLoadNextPage = batch.count <= NewsAPI.maxPage
        downloadWasSuccessful = true
    }
}
