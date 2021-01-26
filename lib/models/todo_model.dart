import 'package:hive/hive.dart';
//hive_generator,build_runner: package ile dosyamızı oluşturacağız
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isDone;
  TodoModel({this.title, this.description, this.isDone});
}

//Terminal: flutter packages pub run build_runner build
//komutu ile build_runner çalıştırılır hive_generator devreye girer
//yukarıdaki part hatasıda geçicektir.

//Example error solution:
//flutter clean
//flutter pub get
//flutter packages pub run build_runner build --delete-conflicting-outputs
