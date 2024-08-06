//
//  SearchViewModel.swift
//  AppStoreMockInterview
//
//  Created by Rajesh Triadi Noftarizal on 06/08/24.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var results: [Result] = [Result]()
    @Published var query = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $query
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self else { return }
                print(newValue)
                self.fetchJSONData(searchValue: newValue)
            }.store(in: &cancellables)
    }
    
    func fetchJSONData(searchValue: String) {
        // Contact for JSON Data
        Task {
            do {
                guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchValue)&entity=software") else { return }
                let (data, _) = try await URLSession.shared.data(from: url)
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                self.results = searchResult.results
                
            } catch {
                print("Failed due to error:", error)
            }
        }
    }
}
