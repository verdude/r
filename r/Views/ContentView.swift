//
//  ContentView.swift
//  r
//
//  Created by e on 4/30/22.
//

import SwiftUI

enum Page {
    case singleImage, search, gallery, video
}

struct ContentView: View {
    @State private var sub: String = ""
    @State private var listings: [Listing] = []
    @State private var view: Page? = Page.search
    @State private var videoId: String?
    @State private var searchStatus: SearchStatus = .waiting
    
    func loadListings() {
        self.listings = requestListing(sub: self.sub)
    }

    var body: some View {
        NavigationView {
            VStack {
                Search(sub: $sub, view: $view, loadListings: loadListings)
                NavigationLink(destination: SubredditGallery(sub: sub, listings: $listings), tag: Page.gallery,
                               selection: $view) { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
