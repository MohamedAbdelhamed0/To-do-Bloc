// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/Cubit/app_cubit.dart';
import '../../manager/constant.dart';
import '../../widgets/buildConditionalBuilder.dart';
import '../../widgets/new task builder.dart';

class NewtaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return buildConditionalBuilder(tasks);
      },
    );
  }
}

//buildTaskItem()
