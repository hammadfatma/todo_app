import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}
