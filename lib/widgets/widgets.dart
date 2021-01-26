import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meplanner/pages/update_todo.dart';
import 'package:meplanner/utils/notification.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

bool isLight = Hive.box('settings').get('isLighTheme', defaultValue: false);

class TodoWidget extends StatelessWidget {
  final int todoKey;
  final String title;
  final String desc;
  final bool isDone;
  TodoWidget({this.todoKey, this.title, this.desc, this.isDone});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            AnimationPageRoute(
                widget: UpdateTodo(
              todoKey: todoKey,
              title: title,
              desc: desc,
              isDone: isDone,
            )));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 24.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color(0xFFFFA500),
                  Color(0xFFFFAE19),
                  Color(0xFFFFB733),
                  Color(0xFFFFC04D),
                  Color(0xFFFFC966),
                  Color(0xFFFFD280),
                ], begin: Alignment.center, end: Alignment.bottomRight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '(Belirtilmedi!)',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      desc ?? '(Görev Açıklaması Belirtilmedi!)',
                      style: TextStyle(
                          height: 1.5,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  )
                ],
              )),
          notificationWidget(context),
        ],
      ),
    );
  }

  Widget notificationWidget(BuildContext context) {
    return Positioned(
        right: 0,
        top: 10,
        child: (IconButton(
          splashRadius: 32,
          icon: Icon(Icons.notifications),
          iconSize: 40,
          onPressed: () {
            if (!isDone) {
              LocalNotification notification = LocalNotification();
              notification.init();
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2020, 3, 8),
                  maxTime: DateTime(2025, 6, 7),
                  onChanged: (date) {}, onConfirm: (date) {
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onConfirm: (time) {
                  notification.showInsistentNotification(
                      todoKey: todoKey,
                      title: title,
                      bodyText: desc,
                      year: time.year,
                      month: time.month,
                      day: time.day,
                      oclock: time.hour,
                      minute: time.minute);
                }, locale: LocaleType.tr);
              }, currentTime: DateTime.now(), locale: LocaleType.tr);
            } else {
              comlatedNotWorkingNotification(context);
            }
          },
        )));
  }

  comlatedNotWorkingNotification(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('Tamamlanmayan Görevler için Bildirim Oluşturabilirsiniz!'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}

//Scroll'daki rengi gidermek için Kullandım
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSize {
  String title;
  Widget widgetLeft;
  Widget widgetRight;
  CustomAppBar({@required this.title, this.widgetLeft, this.widgetRight});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            gradient: LinearGradient(colors: [
              Color(0xFFFFA500),
              Color(0xFFFFAE19),
              Color(0xFFFFB733),
              Color(0xFFFFC04D),
              Color(0xFFFFC966),
              Color(0xFFFFD280),
            ], begin: Alignment.center, end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widgetLeft ??
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: isLight ? Colors.black : Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 25,
                        color: isLight ? Colors.black : Colors.white),
                  ),
                ),
                widgetRight ??
                    Opacity(
                        opacity: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.info),
                        )),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(60));
  }

  @override
  Widget get child => throw UnimplementedError();
  @override
  Size get preferredSize => Size(60, 60);
}

class RaisedGradientButton extends StatelessWidget {
  final String buttonText;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.buttonText,
    this.gradient,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFA500),
            Color(0xFFFFAE19),
            Color(0xFFFFB733),
            Color(0xFFFFC04D),
            Color(0xFFFFC966),
            Color(0xFFFFD280),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
        borderRadius: new BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
                child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: isLight ? Colors.black : Colors.white),
            ))),
      ),
    );
  }
}

class AnimationPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimationPageRoute({this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.fastOutSlowIn);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
