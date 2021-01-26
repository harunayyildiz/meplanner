class TodoModel {
  int id;
  String title;
  String description;
  bool isDone;
  TodoModel({this.id, this.description, this.title, this.isDone});
  //Todo Map'e çevir
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['isDone'] = isDone ? 1 : 0;
    return map;
  }

  //Map convert to TodoModel
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isDone: map['isDone'] == 1 ? true : false);
    //Böyle olmaması gerekiyor
  }
}
