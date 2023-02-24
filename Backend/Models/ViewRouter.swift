//
//  ViewRouter.swift
//  Persona Pop
//
//  Created by Reese Barnett on 2/6/22.
//

import Foundation

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .homeView
    
    // Updates the current page to the new page
    func setPage(to page: Page) {
        currentPage = page
    }
}


enum Page {
    case homeView
    case stageView
    case levelGrid
    case answerField
}
