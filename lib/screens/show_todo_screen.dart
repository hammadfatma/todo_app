import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_cubit.dart';
import 'package:todo_app_bloc/bloc/todo_state.dart';
import 'package:todo_app_bloc/screens/add_todo_screen.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
        listener: (BuildContext context, TodoState state) {},
        builder: (BuildContext context, TodoState state) {
          var cubit = TodoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Show Todo'),
            ),
            body: Column(
              children: [
                cubit.data.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            size: 120,
                          )
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: cubit.data.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                leading: CircleAvatar(
                                  child: Text(
                                    cubit.getName(index)[0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  cubit.getName(index),
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                subtitle: Text(
                                  cubit.getPhone(index),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    cubit.deleteTodo(index);
                                  },
                                  splashRadius: 24,
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
