import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models.dart';

class NotesDatabaseService {
  String path;

  NotesDatabaseService._();

  static final NotesDatabaseService db = NotesDatabaseService._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'notes.db');
    print("Entered path $path");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Notes (_id INTEGER PRIMARY KEY, userEmail TEXT , title TEXT, content TEXT, date TEXT, isImportant INTEGER);');
      await db.execute(
          'CREATE TABLE UserDetail (_id INTEGER PRIMARY KEY, name TEXT, pin TEXT);');
      print('New table created at $path');
    });
  }

  Future<List<NotesModel>> getNotesFromDB(String email) async {
    final db = await database;
    List<NotesModel> notesList = [];
    print("Krishna:$email");
    List<Map> maps = await db.query('Notes',
        columns: [
          '_id',
          'userEmail',
          'title',
          'content',
          'date',
          'isImportant'
        ],
        where: 'userEmail=?',
        whereArgs: [email]);
    print("ULTA SIDHA:${maps.length}");
    if (maps.length > 0) {
      maps.forEach((map) {
        notesList.add(NotesModel.fromMap(map));
      });
    }
    return notesList;
  }

  Future<int> getNotesCntFromDB() async {
    final db = await database;

    final result = await db.rawQuery('SELECT COUNT(*) FROM Notes');
    final count = Sqflite.firstIntValue(result);

    return count;
  }

  updateNoteInDB(NotesModel updatedNote) async {
    final db = await database;
    await db.update('Notes', updatedNote.toMap(),
        where: '_id = ?', whereArgs: [updatedNote.id]);
    print('Note updated: ${updatedNote.title} ${updatedNote.content}');
  }

  deleteNoteInDB(NotesModel noteToDelete) async {
    final db = await database;
    await db.delete('Notes', where: '_id = ?', whereArgs: [noteToDelete.id]);
    print('Note deleted');
  }

  Future<NotesModel> addNoteInDB(NotesModel newNote) async {
    final db = await database;
    if (newNote.title.trim().isEmpty) newNote.title = 'Untitled Note';
    int id = await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into Notes(userEmail, title, content, date, isImportant) VALUES ("${newNote.userEmail}","${newNote.title}", "${newNote.content}", "${newNote.date.toIso8601String()}", ${newNote.isImportant == true ? 1 : 0});');
    });
    newNote.id = id;
    print('Note added: ${newNote.title} ${newNote.content}');
    return newNote;
  }

//User Detail

//Creating user details to db
  Future<UserModel> addUserDetailInDB(UserModel newUser) async {
    final db = await database;
    int id = await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into UserDetail(name, pin) VALUES ("${newUser.name}", "${newUser.pin}");');
    });
    newUser.id = id;
    print('User Added: ${newUser.name} ${newUser.pin}');
    return newUser;
  }

//For getting user details from db
  Future<UserModel> getUserDetailFromDB() async {
    final db = await database;
    List<UserModel> userList = [];
    List<Map> maps =
        await db.query('UserDetail', columns: ['_id', 'name', 'pin']);
    if (maps.length > 0) {
      maps.forEach((map) {
        userList.add(UserModel.fromMap(map));
      });
    }
    return userList[0];
  }
}
