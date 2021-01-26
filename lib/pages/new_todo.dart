import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo_model.dart';
import '../widgets/widgets.dart';

class NewTodo extends StatefulWidget {
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Box<TodoModel> todoBox;
  @override
  void initState() {
    todoBox = Hive.box<TodoModel>('todo');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        // border: InputBorder.none,
        hintText: 'Görev Adını Giriniz',
        contentPadding: EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange.shade100),
        ),
      ),
    );
    final descriptionField = TextFormField(
      controller: descController,
      maxLines: 3,
      decoration: InputDecoration(
        // border: InputBorder.none,
        hintText: 'Görev tanımlayınız',
        contentPadding: EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange.shade100),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Yeni Görev',
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 17, right: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: titleField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: descriptionField,
                  ),
                  RaisedGradientButton(
                    height: 50,
                    width: double.infinity,
                    buttonText: 'Kaydet',
                    onPressed: () async {
                      debugPrint(titleController.text);
                      debugPrint(descController.text);
                      if (titleController.text.length > 0) {
                        TodoModel todo = TodoModel(
                            title: titleController.text,
                            description: descController.text,
                            isDone: false);
                        //Otomatik artış old. için add Kullanıyoruz
                        await todoBox.add(todo);
                        Navigator.pop(context);
                      } else {
                        showInSnackBar('Belirtilen Değerleri Giriniz!');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
        backgroundColor: Colors.orange.shade300,
        content: new Text(
          value,
          style: TextStyle(
              color: isLight ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        )));
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  //  Herhangi bir sayfada Hive ile iletişimini kesmek istersek close metoduyla Kapatabiliriz.
  // }
}
