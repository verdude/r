//
//  SubredditGallery.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation
import SwiftUI

struct SubredditGallery: View {
    var sub: String
    @Binding private var listings: [Listing]
    @State private var videoId: String?
    
    init(sub: String, listings: Binding<[Listing]>) {
        self.sub = sub
        self._listings = listings
    }
    
    private func delete(id: String) {
        listings.removeAll(where: { $0.id == id })
    }
    
    var body: some View {
        List(listings) { listing in
            ImageView(listing: listing, videoId: $videoId, delete: delete(id:))
        }
    }
}
