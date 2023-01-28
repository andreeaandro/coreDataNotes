import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        ValueTransformer.setValueTransformer(
            MotorConfigurationTransformer(),
            forName: NSValueTransformerName("MotorConfigurationTransformer"))

        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Failed to initialize CoreData, \(error)")
            }
        }
    }
}

extension CustomAppSetting {
    static func insert(_ config: MotorConfiguration) {
        let entity = CustomAppSetting(context: CoreDataManager.shared.persistentContainer.viewContext)
        entity.motorConfiguration = config
        try? CoreDataManager.shared.persistentContainer.viewContext.save()
        
        print("Created CustomAppSetting with configs \(entity.motorConfiguration?.maxSpeedLimit)")
    }
    
    static func getAll() -> [CustomAppSetting] {
        let fetchRequest: NSFetchRequest<CustomAppSetting> = CustomAppSetting.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
