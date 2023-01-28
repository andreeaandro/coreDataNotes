import Foundation

public class MotorConfiguration: NSObject, NSSecureCoding {
    let maxSpeedLimit: [String: [Int]]

    init(maxSpeedLimit: [String: [Int]]) {
        self.maxSpeedLimit = maxSpeedLimit
        super.init()
    }
    
    public static var supportsSecureCoding: Bool = true
    public func encode(with coder: NSCoder) {
        coder.encode(maxSpeedLimit, forKey: "maxSpeedLimit")
    }
    public required init?(coder: NSCoder) {
        maxSpeedLimit = coder.decodeObject(forKey: "maxSpeedLimit") as? [String: [Int]] ?? [:]
    }
}

class MotorConfigurationTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let motorConfiguration = value as? MotorConfiguration else {
            print("\(#function) cast issue")
            return nil
        }

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: motorConfiguration, requiringSecureCoding: true)
            return data
        } catch {
            print(error)
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            print("\(#function) nil data value")
            return nil
        }

        do {
            let motorConfiguration = try NSKeyedUnarchiver
                .unarchivedObject(ofClasses: [
                    MotorConfiguration.self, NSDictionary.self,
                    NSArray.self, NSString.self, NSNumber.self],
                                  from: data)
            return motorConfiguration
        } catch {
            print(error)
            return nil
        }
    }
}
