import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../pages/archived_task_pac/archived_task.dart';
import '../../pages/done_task_pac/don_task.dart';
import '../../pages/new_task_pac/new_tasks.dart';
import '../constant.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screens = [
    NewtaskScreen(),
    donetaskScreen(),
    archivedTaskScreen(),
  ];

  List<String> tittle = [
    'Tasks',
    'Donetasks',
    'ArchivedTasks',
  ];

  void screnns(index) {
    currentindex = index;
    emit(changescreen());
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  //create data base
  late Database database;
  List<Map> newTasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivedtasks = [];

  void createDataBase() async {
    database = await openDatabase(
      'todo.db',
      //Ceate data base
      onCreate: (database, version) {
        print('Database created');
        //id int
        //title String
        // date String
        // Status String
        //crate data base table
        database
            .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT ,date TEXT ,time TEXT,status TEXT)',
        )
            .then((value) {
          print('Table Created');
        }).catchError((eror) {
          print(eror);
        });
      },
      version: 1,
      onOpen: (database) {
        getDataFromDataBase(database);
        print('Database Opened');
      },
    ).then((value) {
      emit(createDatabase());
      return database = value;
    });
  }

//String title, String date, String time, String status
  insertToDataBase(
      {required String title,
      required String date,
      required String time}) async {
    return await database!.transaction(
      (txn) {
        return txn
            .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")',
          //[title, date, time, status],
        )
            .then((value) {
          print('$value insert successfully');
          emit(insertDatabase());
          getDataFromDataBase(database);
        }).catchError((e) {
          print(e);
        });
      },
    );
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    Donetasks = [];
    Archivedtasks = [];

    emit(getDatabaseLoadingState());
    database!.rawQuery('SELECT*FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          Donetasks.add(element);
        } else {
          Archivedtasks.add(element);
        }
      });

      emit(getDatabase());
    });
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  bool bottomsheetOpen = false;
  IconData fabIcon = Icons.edit;

  void changeBottomsheetChange({required bool isShow, required IconData icon}) {
    bottomsheetOpen = isShow;
    fabIcon = icon;
    emit(ChangeBottomsheetstate());
  }

  //>>>>>>>>>>>>>>update
  void UpdateDatabase({required String status, required int id}) async {
    return await database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(updatedatabase());
    });
  }

  void deletDatabase({required int id}) async {
    return await database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(Deletdatabase());
    });
  }
}
