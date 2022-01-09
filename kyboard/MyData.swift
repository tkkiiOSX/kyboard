import SwiftUI

class MyData: ObservableObject {
    @Published var name: [String] = []
    @Published var nameRireki: [String] = []

    @Published var sagyo: [String] = []
    @Published var sgyoRireki: [String] = []

    @Published var kiken: [String] = []
    @Published var kikenRireki: [String] = []
    
    @Published var taisaku: [String] = []
    @Published var taisakuRireki: [String] = []


}
