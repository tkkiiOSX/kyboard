import SwiftUI

struct KikenView: View {
    @ObservedObject var data: MyData
    @State var temp = ""
    @State var sel3 = 0

    var body: some View {
        HStack {
            VStack {
                Text("【危険予知】")
                Spacer()
            }
            .frame(width: 200)
            VStack {
                HStack {
                    VStack {
                        ForEach(0 ..< data.kiken.count, id: \.self) {i in
                            Text(data.kiken[i])
                        }
                        Spacer()
                    }
                }
                if data.kikenRireki.count > 0 {
                    HStack {
                        Picker(selection: $sel3, label: Text("危険予知を選択")) {
                            ForEach(0 ..< data.kikenRireki.count, id: \.self) {i in
                                Text(data.kikenRireki[i])
                            }
                        }
                        Button(action: {
                            data.kiken.append(data.kikenRireki[sel3])
                            sel3 = 0
                        }) {
                            Text("危険対策を選択する")
                            }
                        }
                    }
                    HStack {
                        TextField("危険予知を入力ください", text: $temp)
                        Button(action: {
                            data.kiken.append(temp)
                            data.kikenRireki.append(temp)
                            temp = ""
                        }) {
                            Text("危険予知を登録する")
                        }
                }
            }
            .frame(width: 400)
        }
    }
}
