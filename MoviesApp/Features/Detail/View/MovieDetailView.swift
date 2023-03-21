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
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    detailHeaderImageView(geometry: geometry)

                    MovieTextDetailView(textDetail: $viewModel.textDetail)
                        .padding()
                }
            }
        }
        .task {
            await viewModel.fetchMovieDetails()
        }
        .background(Color.backgroundColor.ignoresSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
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
        CacheAsyncImage(url: viewModel.backdropUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Image("poster")
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height / 1.75)
    }

    // MARK: - Public API

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
}

private struct MovieTextDetailView: View {
    @Binding var textDetail: MovieTextDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(textDetail.title)
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color.systemTitleColor)

            Text("\(textDetail.releaseYear)")
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(Color.systemHeadlineColor)

            Text(textDetail.description)
                .font(.body)
                .foregroundColor(Color.systemLightGrey)
                .lineLimit(nil)
                .padding(.top, 20)
        }
    }
}

// MARK: - Preview

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(movieId: 943_822))
    }
}
