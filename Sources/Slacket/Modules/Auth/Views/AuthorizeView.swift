//
//  SlacketView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 02/06/16.
//
//

import Foundation
import Kitura

import TemplateDisplay

enum AuthorizeMessage {
    case authorized
    case authorizationError
    case pocketError

    var filename: String {
        switch self {
        case .authorized: return "auth.html"
        case .authorizationError: return "autherror.html"
        case .pocketError: return "pocketerror.html"
        }
    }

    var context: [String: String] {
        return [String: String]()
    }

}

protocol AuthorizeViewResponder {

    func show(message: AuthorizeMessage)
}

struct AuthorizeView {

    let response: RouterResponse

    func show(message: AuthorizeMessage) {
        //
        let filename = message.filename
        let publicDirectory = repoDirectory+"public/"
        let filePath = publicDirectory+filename
        TemplateDisplay(response: response).show(withPathString: filePath, context: message.context)
    }
}