//
//  MoviesView.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Combine
import SwiftUI

struct MoviesView: View {
    // MARK: - Properties

    @ObservedObject private var viewModel: MoviesViewModel

    var body: some View {
        NavigationView {
            LoadingView(isLoading: $viewModel.isLoading) {
                VStack {
                    // movies list
                    MovieListView()
                }
                .environmentObject(viewModel)
                .navigationTitle("movies_navigation_title")
                .background(Color.backgroundColor)
            }
        }
        .errorAlertState(state: $viewModel.alert)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await viewModel.fetchMovies()
        }
    }

    // MARK: - Public API

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - List

private struct MovieListView: View {
    @EnvironmentObject var viewModel: MoviesViewModel

    var body: some View {
        VStack {
            List {
                ForEach($viewModel.movieArray, id: \.id) { movie in
                    MovieRowView(movie: movie)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .onAppear {
                            Task {
                                await viewModel.getNextPageIfNecessary(movie: movie.wrappedValue)
                            }
                        }
                        .overlay(NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie.wrappedValue)),
                                                label: {
                                                    EmptyView()
                                                })
                                                .isDetailLink(false)
                                                .opacity(0))
                }
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Cell

private struct MovieRowView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    @Binding var movie: Movie

    var body: some View {
        HStack {
            CacheAsyncImage(url: viewModel.moviePosterImageUrl(path: movie.poster)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: .infinity)
                } else {
                    Image("poster")
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: .infinity)
                }
            }

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(Color.systemHeadlineColor)
                    .lineLimit(nil)

                Spacer()

                Text(movie.releaseDate.formattedDate)
                    .font(.footnote)
                    .foregroundColor(Color.systemLightGrey)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Image(systemName: "chevron.compact.right")
                .foregroundColor(Color.systemLightGrey)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Rectangle().fill(Color.white).cornerRadius(8).shadow(color: .gray.opacity(0.3), radius: 8))
    }
}

// MARK: - Preview

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: MoviesViewModel())
    }
}
