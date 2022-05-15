//
//  Networking.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation

private func getUrlSession() -> URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = ["User-Agent": "rapp/v0"]
    return URLSession(configuration: configuration)
}

func requestListing(sub: String) -> [Listing] {
    Logger.debug("Starting listing request for \(sub)")
    let group = DispatchGroup()
    group.enter()
    var listings: [Listing] = []
    let url = URL(string: "https://api.reddit.com/r/\(sub)/hot?limit=10")
    let dataTask = getUrlSession().dataTask(with: url!) {
        data, response, error in
        defer { group.leave() }
        guard let r = response as? HTTPURLResponse
        else {
            Logger.debug("Failure")
            return
        }
        switch (r.statusCode) {
        case 200:
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Root.self, from: data!)
                json.data.children.forEach { child in
                    Logger.debug(String(describing: child.data.preview))
                    if child.data.preview != nil {
                        listings.append(child.data)
                    }
                }
            }
            catch {
                Logger.error("massive decoding failure.")
            }
        default:
            Logger.error("Request returned status code: \(r.statusCode)")
        }
    }
    dataTask.resume()
    let result: DispatchTimeoutResult = group.wait(timeout: DispatchTime.now() + 6)
    Logger.debug("Request for \(sub) dispatch result: \(result)")
    return listings;
}
