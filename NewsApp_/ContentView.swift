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
            
            VStack (alignment: .leading, spacing: 5){
                Text(post.title).font(.title3).fontWeight(.bold)
                Text(post.author ?? "")
                AsyncImage(url: URL(string: post.urlToImage ?? "")) { Image in
                    Image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350)
                        .cornerRadius(30)
                    
                } placeholder: {
                    ProgressView()
                }
                VStack{
//                    Text(post.content).padding(.bottom)
                    Text(post.description ?? "")
                    Text(post.publishedAt)
                
//                    let url: String
//                    let urlToImage: String?
                    Link(destination: URL(string: post.url)!, label: {
                        Text("")
                    })
                }

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
