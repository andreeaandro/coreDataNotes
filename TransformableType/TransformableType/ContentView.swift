import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Insert values in DB") {
                CustomAppSetting.insert(config)
            }
        }
        .padding()
    }
}

let config = MotorConfiguration(maxSpeedLimit: [
    "20mph": [100, 101],
    "25kph": [120, 121],
    "28mph": [150, 151, 152],
    "25kphTW": [50],
    "25kphJP": [45]
])

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
