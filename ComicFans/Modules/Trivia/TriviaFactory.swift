//
//  TriviaFactory.swift
//  ComicFans
//
//  Created by Andrew Masters on 12/1/23.
//

import Foundation

final class TriviaFactory {
    func makeCoordinator() -> TriviaCoordinator {
        let request = TriviaRequest()
        return TriviaCoordinator(request: request)
    }
    
    func makeMediatingController(delegate: TriviaDelegate) -> TriviaMediatingController {
        return TriviaMediatingController(delegate: delegate)
    }
}
