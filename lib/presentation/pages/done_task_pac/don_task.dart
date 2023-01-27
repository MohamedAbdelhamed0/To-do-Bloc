import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/Cubit/app_cubit.dart';
import '../../manager/constant.dart';
import '../../widgets/buildConditionalBuilder.dart';
import '../../widgets/new task builder.dart';

class donetaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).Donetasks;
        return buildConditionalBuilder(tasks);
      },
    );
  }
}
