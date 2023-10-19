

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Students.dart';

class Databases {
  Future<Database> intiDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path , 'students.db') , onCreate: (db , version) {
      db.execute(
        'CREATE TABLE students(id INTEGER PRIMARY KEY , name TEXT ,age INTEGER , marks INTEGER )' ,
      );
    } , version: 1 );
  }
  /**
   * Always keep the database name and
   * Table name in simple way and make sure
   * datamodel name should match the data provided/given
   */

 Future<int> insertStudents (List<Students> students ) async {
    int result = 0;
    final Database db = await intiDB();

    for (var student in students) {
      result = await db.insert('students', student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }
    return result;
 }
 Future<List<Students>> retrieveStudents() async {
    final Database db = await intiDB();

    final List<Map<String , Object?>> queryResult = await db.query('students');

    return queryResult.map((e) => Students.fromMap(e)).toList();

 }

}