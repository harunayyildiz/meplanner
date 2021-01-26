import 'package:flutter/material.dart';
import 'package:meplanner/example/data/services.dart';
import 'package:meplanner/example/models/todo_model.dart';
import 'package:meplanner/example/pages/todo_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Services _services = Services.instance;
  List<TodoModel> todos = [];
  List<TodoModel> todosDone = [];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('mePlanner'),
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.format_list_numbered_rtl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle_outline),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            getTodoList(todos),
            getTodoList(todosDone),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TodoPage()))
                .then((value) => loadData());
            //pop olunca veri güncellensin
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget getTodoList(List<TodoModel> todos) {
    return todos.length == 0
        ? Center(child: Text('Görev Bulunamamaktadır.'))
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(todos[index].title),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.radio_button_checked),
                ),
                subtitle: subtitleControl(todos[index].description),
                trailing: Checkbox(
                  onChanged: (value) {
                    todos[index].isDone = value;
                    _services
                        .updateTodoList(todos[index])
                        .then((value) => loadData());
                  },
                  value: todos[index].isDone,
                ),
              );
            },
          );
  }

  loadData() async {
    todos = await _services.getTodos(true);
    todosDone = await _services.getTodos(false);
    setState(() {});
  }

  subtitleControl(String description) {
    if (description.length > 12) {
      return Text(description.substring(0, 12) + ' ...');
    } else {
      return Text(description);
    }
  }
}
