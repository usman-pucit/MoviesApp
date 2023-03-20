//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import SwiftUI

struct MovieDetailView: View {
    // MARK: - Properties

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: MovieDetailViewModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    detailHeaderImageView(geometry: geometry)

                    MovieTextDetailView(viewModel: viewModel)
                }
            }
        }
        .background(Color.backgroundColor.ignoresSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButtonView)
    }

    private var backButtonView: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.systemWhiteColor)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        })
    }

    private func detailHeaderImageView(geometry: GeometryProxy) -> some View {
        CacheAsyncImage(url: URL(string: viewModel.movie.backdropPath)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image("poster")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height / 1.5)
    }

    // MARK: - Public API

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Movie detail

private struct MovieTextDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(viewModel.movieTexts, id: \.id) { viewModel in
                switch viewModel.type {
                case let .description(imageName, title):
                    descriptionRow(imageName: imageName, title: title)
                case let .source(imageName, title):
                    headlineRow(imageName: imageName, title: title)
                case let .author(imageName, title):
                    headlineRow(imageName: imageName, title: title)
                case let .link(imageName, link, title):
                    linkRow(link: link, imageName: imageName, title: title)
                }
            }
        }
        .padding()
    }

    private func descriptionRow(imageName: String, title: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)

            Text(title)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
        }
        .padding(.bottom, 10)
    }

    private func headlineRow(imageName: String, title: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)

            Text(title)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color.systemLightGrey)
        }
    }

    private func linkRow(link: URL, imageName: String, title _: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)

            Link("Link", destination: link)
        }
    }
}

// MARK: - Preview

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(movie: .init(adult: false, backdropPath: "", genreIds: [], id: 1, language: "", originalTitle: "", overview: "", popularity: 1, poster: "", releaseDate: "", title: "", video: false, voteAverage: 1, voteCount: 1)))
    }
}
