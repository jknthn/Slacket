//
//  APIClient.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import SimpleHttpClient

enum APIRequestSchema: String {
    case Http = "http"
    case Https = "https"
}

protocol ConnectorEndpoint {
    
    var method: RouterMethod { get}
    var schema: APIRequestSchema { get }
    var host: String { get }
    var path: String { get }
    var port: Int { get }
    var fullPath: String { get }
    var headers: [String: String]? { get }
    var acceptContentType: String? { get }
    var acceptHeaders: [String: String]? { get }
    var data: NSData? { get }
}

extension ConnectorEndpoint {
    
    var fullPath: String {
        return "\(self.schema.rawValue)://\(self.host)/\(self.path)"
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var acceptHeaders: [String: String]? {
        return nil
    }
    
    var acceptContentType: String? {
        return nil
    }
    
    var data: NSData? {
        return nil
    }
    
    var resource: HttpResourse {
        return HttpResourse(schema: self.schema.rawValue, host: self.host, port: "\(self.port)", path: self.path)
    }
    
    func request(completionHandler handler: NetworkRequestCompletionHandler) {
        ConnectorProvider.request(endpoint: self, completionHandler: handler)
    }
}

struct ConnectorProvider<Endpoint: ConnectorEndpoint> {
    
    static func request(endpoint: Endpoint, completionHandler handler: NetworkRequestCompletionHandler) {
        switch endpoint.method {
        case .Get:
            HttpClient.get(resource: endpoint.resource, headers: endpoint.headers, completionHandler: handler)
        case .Post:
            HttpClient.post(resource: endpoint.resource, headers: endpoint.headers, data: endpoint.data, completionHandler: handler)
        default:
            fatalError("API Client method not supported")
        }
    }
}