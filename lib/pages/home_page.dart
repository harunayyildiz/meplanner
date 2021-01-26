import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meplanner/utils/notification.dart';
import '../widgets/widgets.dart';
import '../models/todo_model.dart';
import 'new_todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum TodoFilter { ALL, COMPLETED, INCOMPLETED }
//FİLTRELEME İÇİN KULLANIYORUZ

class _HomePageState extends State<HomePage> {
  bool isLight;
  Box<TodoModel> todoBox;
  TodoFilter filter = TodoFilter.ALL;
  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoModel>('todo');
    isLight = Hive.box('settings').get('isLighTheme', defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12, top: 20),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value.compareTo('Tümü') == 0) {
                          setState(() {
                            filter = TodoFilter.ALL;
                          });
                        } else if (value.compareTo('Tamamlanmış') == 0) {
                          setState(() {
                            filter = TodoFilter.COMPLETED;
                          });
                        } else {
                          setState(() {
                            filter = TodoFilter.INCOMPLETED;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.toc,
                        color: Colors.orange,
                        size: 50,
                      ),
                      tooltip: 'Görevlerini Filtrele',
                      padding: EdgeInsets.only(right: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (BuildContext context) {
                        return ["Tümü", "Tamamlanmış", "Tamamlanmamış"]
                            .map((optional) {
                          return PopupMenuItem(
                            value: optional,
                            child: Text(optional),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Box box = Hive.box('settings');
                      box.put('isLighTheme',
                          !box.get('isLighTheme', defaultValue: false));
                      //Renginin tersini tekrar put ettik Tema değiştirildi.
                    },
                    icon: Icon(
                      Icons.brightness_3,
                      color: Colors.orange,
                      size: 40,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoGlowBehaviour(),
                  child: ValueListenableBuilder(
                      valueListenable: todoBox.listenable(),
                      builder: (context, Box<TodoModel> todos, _) {
                        List<int> keys;
                        if (filter == TodoFilter.ALL) {
                          keys = todos.keys.cast<int>().toList();
                        } else if (filter == TodoFilter.COMPLETED) {
                          keys = todos.keys
                              .cast<int>()
                              .where((key) => todos.get(key).isDone)
                              .toList();
                        } else {
                          keys = todos.keys
                              .cast<int>()
                              .where((key) => !todos.get(key).isDone)
                              .toList();
                        }

                        return keys.length != 0
                            ? ListView.builder(
                                itemCount: keys.length,
                                itemBuilder: (context, index) {
                                  final key = keys[index];
                                  //Key'e karşılık gelen değer(Model)
                                  final TodoModel todo = todos.get(key);
                                  return Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (DismissDirection drc) async {
                                      if (drc == DismissDirection.endToStart) {
                                        await todos.delete(key);
                                        //Silinince Bildirim İptal
                                        await LocalNotification()
                                            .cancelNotification(key: key);
                                      } else if (drc ==
                                          DismissDirection.startToEnd) {
                                        //Update
                                        TodoModel mTodo = TodoModel(
                                            title: todo.title,
                                            description: todo.description,
                                            isDone: true);
                                        await todos.put(key, mTodo);
                                        //Tamamlanınca Bildirim iptal
                                        await LocalNotification()
                                            .cancelNotification(key: key);
                                      }
                                    },
                                    // resizeDuration: Duration(milliseconds: 500),
                                    secondaryBackground: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.delete,
                                        size: 50,
                                      ),
                                    ),
                                    background: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        size: 50,
                                      ),
                                    ),
                                    direction: DismissDirection.horizontal,
                                    child: TodoWidget(
                                      todoKey: key,
                                      title: todo.title,
                                      desc: todo.description,
                                      isDone: todo.isDone,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                margin: EdgeInsets.all(40),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/noItem2.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        textlisten(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, AnimationPageRoute(widget: NewTodo()));
        },
        child: Icon(
          Icons.add,
          color: isLight ? Colors.white : Colors.white,
        ),
        splashColor: Colors.orange,
        backgroundColor: isLight ? Colors.black87 : Colors.orange,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  String textlisten() {
    String text = 'Hadi Görev Ekle ve Başla!';
    if (todoBox.length > 0) {
      if (filter == TodoFilter.COMPLETED) {
        text = 'Tamamlanmış Göreviniz Bulunmamaktadır';
      } else if (filter == TodoFilter.INCOMPLETED) {
        text = 'Tamamlanmamış Göreviniz Bulunmamaktadır';
      }
    }
    return text;
  }
}
