import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late GlobalKey<ScaffoldState> scaffoldKey;

  late GlobalKey<FormState> formKey;

  late TextEditingController titleController;

  late TextEditingController timeController;

  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    timeController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    timeController.dispose();
    titleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2024-06-07'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMEd().format(value!);
                                      });
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefix: Icons.calendar_today,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                    timeController.clear();
                    dateController.clear();
                    titleController.clear();
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.iconFab),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
