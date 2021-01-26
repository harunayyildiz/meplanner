import 'package:flutter/material.dart';
import 'package:meplanner/example/data/services.dart';
import 'package:meplanner/example/models/todo_model.dart';
import 'package:meplanner/widgets/widgets.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Services _services = Services.instance;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      appBar: AppBar(
        title: Text('Yeni Görev'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: titleField,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  _services
                      .addTodoList(TodoModel(
                          id: null,
                          title: titleController.text,
                          description: descController.text,
                          isDone: false))
                      .then((value) => Navigator.pop(context));
                } else {
                  showInSnackBar('Belirtilen Değerleri Giriniz!');
                }
              },
            ),
          ],
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
}
