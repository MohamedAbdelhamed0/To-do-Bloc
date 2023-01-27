import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_bloc/presentation/manager/Cubit/Observing%20a%20Cubit.dart';
import 'package:to_do_app_bloc/presentation/manager/constant.dart';
import 'package:to_do_app_bloc/presentation/pages/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(todoapp());
}

class todoapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: textcolor,
        toggleableActiveColor: textcolor,
        primaryColor: textcolor,
        indicatorColor: textcolor,
        drawerTheme: DrawerThemeData(backgroundColor: textcolor),
        dataTableTheme:
            DataTableThemeData(decoration: BoxDecoration(color: textcolor)),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: textcolor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
