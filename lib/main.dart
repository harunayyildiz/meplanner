import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/todo_model.dart';
import 'pages/home_page.dart';

//Flutter_hive paketini kullanmamış olsaydık:
// WidgetsFlutterBinding.ensureInitialized();
// final docDirectory = await pathProvider.getApplicationDocumentsDirectory();
// Hive.init(docDirectory.path);
//şeklinde bir kullanımımız olucaktı.
//hive_flutter paketindeki initFlutter'da pathProviderden extend edilmiş.
//ValueListenableBuilder widget'ındaki listenable(), hive_flutterdan gelmektedir
//Bu paket sayesinde içindeki veri dinlenip değiştiriliyor.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox('settings');
  await Hive.openBox<TodoModel>('todo');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

//settings Kutusunun içindeki isLighTheme değişince tetiklenicek yapı
//Eğerki anahtar kısıtı koymazsak herhangi bir değişimde tetiklenicektir
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('settings').listenable(keys: ['isLighTheme']),
      builder: (context, box, widget) {
        return MaterialApp(
          title: 'mePlanner',
          debugShowCheckedModeBanner: false,
          theme: box.get('isLighTheme', defaultValue: false)
              ? ThemeData.light()
              : ThemeData.dark(),
          home: HomePage(),
        );
      },
    );
  }
}
