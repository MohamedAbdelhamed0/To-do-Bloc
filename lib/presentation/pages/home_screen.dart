// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../manager/Cubit/app_cubit.dart';
import '../manager/constant.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import '../widgets/text field.dart';

class HomeLayout extends StatelessWidget {
  Database? database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var myTimeController = TextEditingController();
  var myDateController = TextEditingController();
  var myTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is insertDatabase) {
            Navigator.pop(context);
            myTimeController.clear();
            myDateController.clear();
            myTaskController.clear();
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            primary: true,
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: primaypcolor,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: primaypcolor,
                systemStatusBarContrastEnforced: true,
              ),
              shadowColor: Colors.blue,
              centerTitle: true,
              title: Text(
                cubit.tittle[cubit.currentindex].toUpperCase(),
                style: mystyle,
              ),
            ),
            floatingActionButton: buildFloatingActionButton(cubit),
            bottomNavigationBar: buildBottomNavigationBar(cubit),
            body: ConditionalBuilder(
              condition: state is! getDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentindex],
              fallback: (context) => Center(
                  child: CircularProgressIndicator(
                color: Colors.pink,
              )),
            ),
          );
        },
      ),
    );
  }

  BackdropFilter bottomSheetBackdropFilter(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Textfieldup(
                Lable: 'New task',
                context: context,
                keyboardtype: TextInputType.text,
                myicon: Icons.title_sharp,
                myTimeController: myTaskController,
                ontap: () {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Textfieldup(
                Lable: 'Enter Date',
                context: context,
                keyboardtype: TextInputType.none,
                myicon: Icons.date_range,
                myTimeController: myDateController,
                ontap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.parse('2023-12-30'),
                  ).then((value) {
                    myDateController.text =
                        DateFormat.yMMMd().format(value!).toString();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please date the time';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Textfieldup(
                Lable: 'Enter Time',
                context: context,
                keyboardtype: TextInputType.none,
                myicon: Icons.timer,
                myTimeController: myTimeController,
                ontap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    myTimeController.text = value!.format(context).toString();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(AppCubit cubit) {
    return FloatingActionButton(
      backgroundColor: textcolor.withAlpha(250),
      onPressed: () {
        if (cubit.bottomsheetOpen) {
          if (formkey.currentState!.validate()) {
            cubit.insertToDataBase(
                title: myTaskController.text,
                date: myDateController.text,
                time: myTimeController.text);
          }
        } else {
          scaffoldKey.currentState!
              .showBottomSheet(
                backgroundColor: primaypcolor,
                (context) => bottomSheetBackdropFilter(context),
              )
              .closed
              .then((value) {
            cubit.changeBottomsheetChange(
              isShow: false,
              icon: Icons.edit,
            );
          });
          cubit.changeBottomsheetChange(isShow: true, icon: Icons.add);
        }
      },
      // ignore: sort_child_properties_last
      child: Icon(
        cubit.fabIcon,
        color: primaypcolor,
      ),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      disabledElevation: 50,
      highlightElevation: 50,
      isExtended: true,
      elevation: 2,
    );
  }

  BottomNavigationBar buildBottomNavigationBar(AppCubit cubit) {
    return BottomNavigationBar(
      backgroundColor: primaypcolor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: textcolor,
      enableFeedback: true,
      mouseCursor: MouseCursor.defer,
      selectedFontSize: 20,
      selectedIconTheme: IconThemeData(size: 30),
      unselectedFontSize: 15,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      selectedLabelStyle: mystyle.copyWith(fontSize: 20),
      currentIndex: cubit.currentindex,
      onTap: (index) {
        cubit.screnns(index);
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(FontAwesome5.pen),
          icon: Icon(FontAwesome5.thumbtack),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.check_circle_outline),
          icon: Icon(FontAwesome5.check_circle),
          label: 'Done',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.archive_outlined),
          icon: Icon(Icons.archive),
          label: 'Archived',
        ),
      ],
    );
  }
}
