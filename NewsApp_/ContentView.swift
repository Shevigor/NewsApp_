//
//  ContentView.swift
//  NewsApp_
//
//  Created by user on 14.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State var news: [Article]  = []
    var body: some View {
            List(news){ post in
                VStack{
                    Text(post.title).padding(5).font(.title3).fontWeight(.bold)
                    Text(post.author ?? "").padding(5)
                    Text(post.content).padding(.bottom)
                    Text(post.description ?? "")
                    Text(post.publishedAt)

//                    let url: String
//                    let urlToImage: String?
                }
            }
            .onAppear {
                ViewModel().getData { (news) in
                    self.news = news
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
