import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../manager/Cubit/app_cubit.dart';
import '../manager/constant.dart';

Widget buildTaskItem(Map model, context) {
  File imageFile = File(model['image_path']);
  Image image = Image.file(imageFile);
  return Dismissible(
    movementDuration: Duration(seconds: 3),
    key: Key(model['id'].toString()),
    onDismissed: (value) {
      AppCubit.get(context).deletDatabase(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaypcolor,
              borderRadius: BorderRadius.circular(20),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                // ignore: prefer_const_constructors
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6, left: 6),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaypcolor,
                        boxShadow: [
                          BoxShadow(
                            color: textcolor,
                            offset: Offset(0, 0),
                            blurRadius: .5,
                            spreadRadius: .5,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${model['time']}',
                          style: mystyle.copyWith(fontSize: 15, shadows: [
                            BoxShadow(color: Colors.black, offset: Offset(1, 0))
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        '${model['title']}',
                        style: mystyle.copyWith(fontSize: 25, shadows: [
                          BoxShadow(color: Colors.black, offset: Offset(1, 0))
                        ]),
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'End in :',
                            style: mystyle.copyWith(fontSize: 12),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${model['date']}',
                            style: mystyle.copyWith(fontSize: 15, shadows: [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(1, 0))
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 1),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).UpdateDatabase(
                                status: 'done',
                                id: model['id'],
                              );
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: textcolor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).UpdateDatabase(
                                status: 'archive',
                                id: model['id'],
                              );
                            },
                            icon: Icon(
                              Icons.archive,
                              color: textcolor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: Image(image: FileImage(File(model['image_path']))),
          )
        ],
      ),
    ),
  );
}
