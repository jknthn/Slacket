//
//  Slacket.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

#if os(Linux)
    import Glibc
#endif



struct Slacket: ServerModuleType {
    
    let router: Router
    
    init(using router: Kitura.Router) {
        self.router = router
        self.setupRoutes()
    }
    
    mutating func setupRoutes() {
        
        router.all("api/*", middleware: BodyParser())
        
        // setup inbound slack URL
        /*
        router.post(SlackCommandService.endpoint.route,
                    middleware: SlackCommandService(),
                    SlacketUserService(),
                    // SlacketSessionService()
                    PocketAddService(),
                    SlackMessageService()
                    // TODO: Define message templates
        )
        
        router.get(PocketAuthorizationRequestService.endpoint.route,
                    middleware: PocketAuthorizationRequestService()
        )
        
        router.get(PocketAuthorizationResponseService.endpoint.route,
                   middleware: PocketAuthorizationResponseService()
                   // SlacketUserService()
                   // SlacketSessionService()
                   // SlackMessageService()
                   // WebViewService()
            // TODO: Introduce Emitter service that terminates response chain
        )
        */
        router.get("api/*") { request, response, next in
            do {
                try response.end()
            }
            catch {
                Log.error("Failed to send response \(error)")
            }
        }
    }
}