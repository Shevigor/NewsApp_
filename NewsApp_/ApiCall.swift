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
            
            print("JSON:")
            print(String(data: data, encoding: .utf8) ?? "-")
  
            do {
//++ 1 variant
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
//                let news = try decoder.decode(NewsApi.self, from: data)
//-- 1 variant
                
//++ 2 variant
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let news = try decoder.decode(NewsApi.self, from: data)
//-- 2 variant
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

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
//          "publishedAt": "2023-06-09T04:17:42.000Z",
//    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

//                          2023-06-13T14:03:23Z
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
