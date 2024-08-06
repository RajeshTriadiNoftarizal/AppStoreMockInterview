//
//  ContentView.swift
//  AppStoreMockInterview
//
//  Created by Rajesh Triadi Noftarizal on 05/08/24.
//

import SwiftUI

struct SearchView: View {
    
    // ObservedObject <- more for dependecy injection
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    
                    if vm.results.isEmpty && vm.query.isEmpty {
                        ContentUnavailableView("Please Enter your search", systemImage: "sparkle.magnifyingglass")
                    } else {
                        ScrollView {
                            ForEach(vm.results.prefix(3)) { result in
                                VStack(spacing: 16) {
                                    
                                    AppIconTitleView(result: result)
                                    
                                    ScreenshotsRow(proxy: proxy, result: result)
                                }
                                .padding(16)
                            }
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("Search")
            .searchable(text: $vm.query)
            //            .onChange(of: query) {
            //                print(query)
            //            }
        }
    }
}

struct AppIconTitleView: View {
    
    let result: Result
    
    var body: some View {
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: result.artworkUrl512)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(result.trackName)
                    .lineLimit(1)
                    .font(.system(size: 20))
                Text(result.primaryGenreName)
                    .foregroundStyle(.gray)
                
                HStack(spacing: 1) {
                    
                    ForEach(0..<Int(result.averageUserRating), id: \.self) { num in
                            Image(systemName: "star.fill")
                    }
                    
                    ForEach(0..<5 - Int(result.averageUserRating), id: \.self) { num in
                            Image(systemName: "star")
                    }
                    
                    Text("\(result.userRatingCount.roundedWithAbbreviations)")
                        .padding(.leading, 4)
                }
                .padding(.top, 0)
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "icloud.and.arrow.down")
                    .font(.system(size: 24))
            })
        }
    }
}

struct ScreenshotsRow: View {
    let proxy: GeometryProxy
    let result: Result
    
    var body: some View {
        let width = (proxy.size.width - 4 * 16) / 3
        
        HStack(spacing: 16) {
            ForEach(result.screenshotUrls.prefix(3), id: \.self) { screenshotURL in
                AsyncImage(url: URL(string: screenshotURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: width, height: 200)
                }
            }
        }
    }
}


#Preview {
    SearchView()
        .preferredColorScheme(.dark)
}

