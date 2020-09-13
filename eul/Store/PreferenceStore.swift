//
//  PreferenceStore.swift
//  eul
//
//  Created by Gao Sun on 2020/8/15.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import Foundation
import Combine
import Localize_Swift
import SwiftyJSON

class PreferenceStore: ObservableObject {
    static let shared = PreferenceStore()
    static var availableLanguages: [String] {
        Localize.availableLanguages().filter { $0 != "Base" }
    }

    private let userDefaultsKey = "preference"
    private var cancellable: AnyCancellable?

    @Published var temperatureUnit = TemperatureUnit.celius {
        willSet {
            SmcControl.shared.tempUnit = newValue
        }
    }
    @Published var language = Localize.currentLanguage() {
        willSet {
            Localize.setCurrentLanguage(newValue)
        }
    }
    @Published var textDisplay = Preference.TextDisplay.compact
    @Published var isActiveComponentToggling = false
    @Published var activeComponents = EulComponent.allCases
    @Published var availableComponents: [EulComponent] = []

    var json: JSON {
        JSON([
            "temperatureUnit": temperatureUnit.rawValue,
            "language": language,
            "textDisplay": textDisplay.rawValue,
            "activeComponents": activeComponents.map { $0.rawValue },
            "availableComponents": availableComponents.map { $0.rawValue }
        ])
    }

    init() {
        loadFromDefaults()
        cancellable = objectWillChange.sink {
            DispatchQueue.main.async {
                self.saveToDefaults()
            }
        }
    }

    func toggleActiveComponent(at index: Int) {
        isActiveComponentToggling = true
        availableComponents.append(activeComponents[index])
        activeComponents.remove(at: index)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // wait for rendering, will crash w/o delay
            self.isActiveComponentToggling = false
        }
    }

    func toggleAvailableComponent(at index: Int) {
        activeComponents.append(availableComponents[index])
        availableComponents.remove(at: index)
    }

    func loadFromDefaults() {
        if let raw = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                let data = try JSON(data: raw)

                print("⚙️ loaded data from user defaults", data)

                if let raw = data["temperatureUnit"].string, let value = TemperatureUnit(rawValue: raw) {
                    temperatureUnit = value
                }
                if let value = data["language"].string {
                    language = value
                }
                if let raw = data["textDisplay"].string, let value = Preference.TextDisplay(rawValue: raw) {
                    textDisplay = value
                }
                if let array = data["activeComponents"].array {
                    activeComponents = array.compactMap {
                        if let string = $0.string {
                            return EulComponent(rawValue: string)
                        }
                        return nil
                    }
                }
                if let array = data["availableComponents"].array {
                    availableComponents = array.compactMap {
                        if let string = $0.string {
                            return EulComponent(rawValue: string)
                        }
                        return nil
                    }
                }
            } catch {
                print("Unable to get preference data from user defaults")
            }
        }
    }

    func saveToDefaults() {
        do {
            let data = try json.rawData()
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Unable to get preference data")
        }
    }
}
