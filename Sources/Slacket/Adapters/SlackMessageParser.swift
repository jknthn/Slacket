//
//  SlackMessageParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation

import Foundation
import Kitura
import SwiftyJSON

private extension SlackMessageVisibility {
    
    var slackValue: String {
        switch self {
        case .Ephemeral:
            return "ephemeral"
        case .InChannel:
            return "in_channel"
        }
    }
}

struct SlackMessageParser: ParserEncoderType {
    
    typealias Parsable = SlackMessageType
    typealias ParsedType = JsonType
    
    static func encode(model: Parsable) -> ParsedType? {
        var dictionary = [String: String]()
        dictionary["text"] = model.text
        dictionary["response_type"] = model.responseVisibility.slackValue
        
        return JSON(dictionary)
    }
}