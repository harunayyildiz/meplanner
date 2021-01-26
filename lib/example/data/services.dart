import 'dart:io';
import 'package:meplanner/example/models/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Services {
  //Her kullanacağımız sayfada bir instance oluşturmaktansa bu yapıyı kullanmalıyız
  //Her instance ramde bir yer ayrılması demektir.
  static Services instance = Services._internal();
  Services._internal();
  factory Services() {
    return instance;
  }
  //
  static List<TodoModel> todos = [];
  static Database _db; //Instance tanımlama
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initdb();
    }
    return _db;
  }

  Future<Database> _initdb() async {
    //Dosya üzerinden db modelleme
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo.db';
    final todoDb = await openDatabase(path, version: 1, onCreate: _createDb);
    //onCreate fonksiyonu 2 parametreli Package özelliğinden
    return todoDb;
  }

  _createDb(Database db, int versiyon) async {
    await db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,isDone INT)');
    //Sqflite bool Değişken tipi yoktur.
  }

  Future<List<TodoModel>> getTodos(bool isDone) async {
    final mapList = await getTodoMaps();
    List<TodoModel> todoList = [];
    mapList.forEach((element) {
      todoList.add(TodoModel.fromMap(element));
      //elementi yolladık TodoModel'e çevirip listemize ekleyecek
    });

    if (isDone) {
      return todoList.where((element) => !element.isDone).toList();
    }
    return todoList.where((element) => element.isDone).toList();
  }

  Future<List<Map<String, dynamic>>> getTodoMaps() async {
    Database db = await this.db;
    return await db.query('todos');
    //Select * from todos metodu :)
  }

  Future<int> addTodoList(TodoModel todo) async {
    Database db = await this.db;
    return await db.insert('todos', todo.toMap());
  }

  Future<int> updateTodoList(TodoModel todo) async {
    Database db = await this.db;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id=?',
      // ? : whereArgs içindeki id'ler sırasıyla id alanına karşılık set edilmesini sağlar
      whereArgs: [todo.id],
    );
  }
}
//Metodların int tipinde olması kayıtlarda başarılı olan kayıt sayını temsil eder
