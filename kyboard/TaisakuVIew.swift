import SwiftUI

struct TaisakuView: View {
    @ObservedObject var data: MyData
    @State var temp = ""
    @State var sel4 = 0

    var body: some View {
        HStack {
            VStack {
                Text("【安全対策】")
                Spacer()
            }
            .frame(width: 200)
            VStack {
                HStack {
                    VStack {
                        ForEach(0 ..< data.taisaku.count, id: \.self) {i in
                            Text(data.taisaku[i])
                        }
                        Spacer()
                    }
                }
                if data.taisakuRireki.count > 0 {
                    HStack {
                        Picker(selection: $sel4, label: Text("安全対策を選択")) {
                            ForEach(0 ..< data.taisakuRireki.count, id: \.self) {i in
                                Text(data.taisakuRireki[i])
                            }
                        }
                        Button(action: {
                            data.taisaku.append(data.taisakuRireki[sel4])
                            sel4 = 0
                        }) {
                            Text("危険対策を選択する")
                            }
                        }
                    }
                HStack {
                    TextField("安全対策を入力ください", text: $temp)
                    Button(action: {
                        data.taisaku.append(temp)
                        data.taisakuRireki.append(temp)
                        temp = ""
                    }) {
                        Text("安全対策を登録する")
                    }
                }
            }
            .frame(width: 400)
        }
    }
}
