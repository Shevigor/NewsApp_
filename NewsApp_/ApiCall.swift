//
//  ApiCall.swift
//  NewsApp_
//
//  Created by user on 14.06.2023.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var news = [Article]()
    @Published var url = "https://newsapi.org/v2/everything?q=russia&from=2023-06-13&sortBy=publishedAt&apiKey=738532ff6fa744bbace87c5cec79940e"
    
    
    func getData(complition: @escaping ([Article]) -> ()) {
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {return}
            print("111", data)
            do {
                let news = try JSONDecoder().decode(NewsApi.self, from: data)
                print("Status: ", news.status)
                print("Total result: ", news.totalResults)
//                print(news.articles.first ?? "")
//                print(news.articles.first?.publishedAt ?? "")
//                print(news.articles.first?.author ?? "")
//                print(news.articles.first?.title ?? "")
//                print(news.articles.first?.description ?? "")
                DispatchQueue.main.async {
                    complition(news.articles)
                }
            } catch {
                print("Error decoded JSON -", error)
            }
        }
        task.resume()
    }
}
