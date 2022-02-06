import SwiftUI

struct NameView: View {
    @ObservedObject var data: MyData
    @State var temp = ""
    @State var sel1 = 0
    @State var deleAlert = false

    @State var indexSave: IndexSet = IndexSet()

    //追記
    let def = UserDefaults.standard

    var body: some View {
        VStack {
            Text("【氏名・血液型】")
            EditButton()
            List {
                ForEach(0 ..< data.name.count, id: \.self) {i in
                    Text(data.name[i])
                }
                .onDelete { indexDel in
                    data.name.remove(atOffsets: indexDel)
                }
                .onMove { src, dst in
                    data.name.move(fromOffsets: src, toOffset: dst)
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
                        //追記
                        def.set(data.name, forKey: "Test1" )
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
                    //追記
                    def.set(data.name, forKey: "Test1" )
                    def.set(data.nameRireki, forKey: "Test2")
                }) {
                    Text("名前を登録する")
                }
            }

            //.frame(width: 400)

        }
    }
}
struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(data: MyData())
    }
}
