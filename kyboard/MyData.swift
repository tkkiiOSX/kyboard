import SwiftUI

class MyData: ObservableObject {

    @Published var yyyymmdd: Date?

    @Published var name: [String] = []
    @Published var nameRireki: [String] = []

    @Published var sagyo: [String] = []
    @Published var sagyoRireki: [String] = []

    @Published var kiken: [String] = []
    @Published var kikenRireki: [String] = []
    
    @Published var taisaku: [String] = []
    @Published var taisakuRireki: [String] = []

}
