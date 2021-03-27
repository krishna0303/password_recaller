import 'dart:math';

class NotesModel {
  int id;
  String userEmail;
  String title;
  String content;
  bool isImportant;
  DateTime date;

  NotesModel(
      {this.id,
      this.userEmail,
      this.title,
      this.content,
      this.isImportant,
      this.date});

  NotesModel.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.userEmail = map['userEmail'];
    this.title = map['title'];
    this.content = map['content'];
    this.date = DateTime.parse(map['date']);
    this.isImportant = map['isImportant'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'userEmail': this.userEmail,
      'title': this.title,
      'content': this.content,
      'isImportant': this.isImportant == true ? 1 : 0,
      'date': this.date.toIso8601String()
    };
  }

  NotesModel.random() {
    this.id = Random(10).nextInt(1000) + 1;
    this.userEmail = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);

    this.title = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);
    this.content = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);
    this.isImportant = Random().nextBool();
    this.date = DateTime.now().add(Duration(hours: Random().nextInt(100)));
  }
}

class UserModel {
  int id;
  String name;
  String pin;

  UserModel({this.id, this.name, this.pin});

  UserModel.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.name = map['name'];
    this.pin = map['pin'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'name': this.name,
      'pin': this.pin,
    };
  }
}
