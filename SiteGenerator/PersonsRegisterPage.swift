import Foundation

class PersonsRegisterPage : Page {
    
    private let personsRegister: PersonsRegister
    
    init(_ personsRegister: PersonsRegister) {
        self.personsRegister = personsRegister
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        mainChildren.append(personsRegister.renderPersonsRegister())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
}
