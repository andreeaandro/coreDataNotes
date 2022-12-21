import Foundation
import CoreData

protocol BaseModel {
    func save() throws
    func delete() throws
    static func byId<T: NSManagedObject>(id: NSManagedObject) -> T?
    static func all<T: NSManagedObject>() -> [T]
}

extension BaseModel {
    
}
