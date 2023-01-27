// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../manager/constant.dart';
import 'new task builder.dart';

ConditionalBuilder buildConditionalBuilder(List<Map<dynamic, dynamic>> tasks) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => Container(
      color: primaypcolor,
      child: ListView.separated(
          itemBuilder: ((context, index) =>
              buildTaskItem(tasks[index], context)),
          separatorBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, top: 8, left: 40, right: 40),
                child: SizedBox(
                  width: 10,
                  height: .9,
                  child: Container(
                    color: textcolor,
                  ),
                ),
              )),
          itemCount: tasks.length),
    ),
    fallback: (context) => Container(
      color: primaypcolor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                  child: Column(
                children: [
                  Icon(
                    Icons.task,
                    size: 100,
                    shadows: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(-2, -2),
                      )
                    ],
                    color: textcolor,
                  ),
                  Text(
                    'No Tasks Yet Please Add some Tasks',
                    style: mystyle.copyWith(
                      fontSize: 20,
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(-2, -2),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ADD TASK',
                    style: mystyle.copyWith(
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(-2, -2),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 100,
                    shadows: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(-2, -2),
                      )
                    ],
                    color: textcolor,
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
