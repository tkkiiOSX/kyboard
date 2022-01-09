import SwiftUI

struct NameView: View {
    @ObservedObject var data: MyData
    @State var temp = ""
    @State var sel1 = 0

    var body: some View {
        HStack {
            VStack {
                Text("【氏名・血液型】")
                Spacer()
            }
            .frame(width: 200)
            VStack {
                HStack {
                    VStack {
                        ForEach(0 ..< data.name.count, id: \.self) {i in
                            Text(data.name[i])
                        }
                        Spacer()
                    }
                    
                }
                if data.nameRireki.count > 0 {
                    HStack {
                        Picker(selection: $sel1, label: Text("名前選択")) {
                            ForEach(0 ..< data.nameRireki.count, id: \.self) {i in
                                Text(data.nameRireki[i])
                            }
                        }
                        Button(action: {
                            data.name.append(data.nameRireki[sel1])
                            sel1 = 0
                        }) {
                            Text("名前を選択する")
                        }
                    }
                }

                HStack {
                    TextField("氏名・血液型・＋ーを入力ください", text: $temp)
                    Button(action: {
                        data.name.append(temp)
                        data.nameRireki.append(temp)
                        temp = ""
                    }) {
                        Text("名前を登録する")
                    }
                }
            }
            .frame(width: 400)
        }
    }
}
struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(data: MyData())
    }
}
