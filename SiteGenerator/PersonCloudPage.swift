//
//  PersonCloudPage.swift
//  SiteGenerator
//
//  Created by Christian on 06.10.23.
//  Copyright © 2023 Christian. All rights reserved.
//

import Foundation

class PersonCloudPage : Page {
    
    private let personsRegister: PersonsRegister
    
    init(_ personsRegister: PersonsRegister) {
        self.personsRegister = personsRegister
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(personsRegister.renderRegisterCloud())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(personsTitle)
    }
}
