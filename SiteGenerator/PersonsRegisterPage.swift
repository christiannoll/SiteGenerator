import Foundation

class PersonsRegisterPage : Page {
    
    private let personsRegister: PersonsRegister
    
    init(_ personsRegister: PersonsRegister) {
        self.personsRegister = personsRegister
    }
    
    override func renderContent() -> SmlNode {
        var mainChildren: [SmlNode] = [newLine]
        let h_title = h3([.text(personsTitle)])
        mainChildren.append(h_title)
        mainChildren.append(newLine)
        mainChildren.append(personsRegister.renderPersonsRegister())
        
        mainChildren.append(newLine)
        return main(mainChildren)
    }
    
    func setTitle() {
        setTitle(personsTitle)
    }
}
