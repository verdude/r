//
//  Search.swift
//  r
//
//  Created by e on 5/10/22.
//

import SwiftUI

enum SearchStatus {
    case ready, waiting
}

struct Search: View {
    @Binding var sub: String
    @Binding var view: Page?
    @Binding var status: SearchStatus
    
    var body: some View {
        VStack {
            TextField("r/", text: $sub, prompt: Text("Subreddit"))
                .onSubmit {
                    Logger.debug("haha! \(sub)")
                    view = Page.gallery
                    status = .ready
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onAppear {
                    status = .waiting
                }
        }
    }
}
