//
//  SubredditGallery.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation
import SwiftUI

struct SubredditGallery: View {
    @Binding private var view: Page?
    @Binding private var sub: String
    @Binding private var status: SearchStatus
    @State private var listings: [Listing]
    @State private var videoId: String?
    
    init(view: Binding<Page?>, sub: Binding<String>, status: Binding<SearchStatus>) {
        self._view = view
        self._sub = sub
        self._status = status
        self.listings = []
    }
    
    private func delete(id: String) {
        listings.removeAll(where: { $0.id == id })
    }
    
    var body: some View {
        switch status {
        case .ready:
            List(requestListing(sub: sub)) { listing in
                ImageView(view: $view, listing: listing, videoId: $videoId, delete: delete(id:))
            }
        case .waiting:
            Text("...go back...")
        }
    }
}
