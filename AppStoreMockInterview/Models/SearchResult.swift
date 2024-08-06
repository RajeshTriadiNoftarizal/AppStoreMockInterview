//
//  SearchResult.swift
//  AppStoreMockInterview
//
//  Created by Rajesh Triadi Noftarizal on 06/08/24.
//

import Foundation

struct SearchResult: Codable {
    let results: [Result]
}

struct Result: Codable, Identifiable {
    var id: Int { trackId }
    let trackId: Int
    let trackName: String
    let artworkUrl512: String
    let primaryGenreName: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let userRatingCount: Int
}
