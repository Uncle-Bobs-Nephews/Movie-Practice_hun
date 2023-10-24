//
//  SearchMoviesUseCase.swift
//  MoviePractice
//
//  Created by 전성훈 on 2023/10/23.
//

import Foundation

protocol SearchMoviesUseCase {
    func execute(
        requestValue: SearchMoviesUseCaseRequestValue,
        cached: @escaping (MoviesPage) -> Void,
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> Cancellable?
}

struct SearchMoviesUseCaseRequestValue {
    let query: MovieQuery
    let page: Int
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    
    private let moviesRepository: MoviesRepository
    private let moviesQueriesRepository: MoviesQueriesRepository
    
    init(
        moviesRepository: MoviesRepository,
        moviesQueriesRepository: MoviesQueriesRepository
    ) {
        self.moviesRepository = moviesRepository
        self.moviesQueriesRepository = moviesQueriesRepository
    }
    
    // TODO: 뭘 의미하는걸까??
    func execute(requestValue: SearchMoviesUseCaseRequestValue, cached: @escaping (MoviesPage) -> Void, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        return moviesRepository.fetchMoviesList(query: requestValue.query, page: requestValue.page, cached: cached) { result in
            if case .success = result {
                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }
            
            completion(result)
        }
    }
}
