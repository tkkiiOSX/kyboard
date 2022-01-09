import SwiftUI

struct SagyoView: View {
    @ObservedObject var data: MyData
    @State var temp = ""
    @State var sel2 = 0

    var body: some View {
        HStack {
            VStack {
                Text("【作業内容】")
                Spacer()
            }
            .frame(width: 200)
            VStack {
                HStack {
                    VStack {
                        ForEach(0 ..< data.sagyo.count, id: \.self) {i in
                            Text(data.sagyo[i])
                        }
                        Spacer()
                    }

                }
                if data.sgyoRireki.count > 0 {
                    HStack {
                        Picker(selection: $sel2, label: Text("作業内容を選択")) {
                            ForEach(0 ..< data.sgyoRireki.count, id: \.self) {i in
                                Text(data.sgyoRireki[i])
                            }
                        }
                        Button(action: {
                            data.sagyo.append(data.sgyoRireki[sel2])
                            sel2 = 0
                        }) {
                            Text("作業内容を選択する")
                        }
                    }
                }
                HStack {
                    TextField("作業内容を入力ください", text: $temp)
                    Button(action: {
                        data.sagyo.append(temp)
                        data.sgyoRireki.append(temp)
                        temp = ""
                    }) {
                        Text("作業内容を登録する")
                    }
                }
            }
            .frame(width: 400)
        }
    }
}

struct SagyoView_Previews: PreviewProvider {
    static var previews: some View {
        SagyoView(data: MyData())
    }
}
