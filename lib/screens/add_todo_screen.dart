import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_cubit.dart';

import '../models/data.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cName = TextEditingController();
    final TextEditingController cPhoneNumber = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  icon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
                autofocus: true,
                controller: cName,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Telephone',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 16,
                controller: cPhoneNumber,
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    String nam = cName.text;
                    String phone = cPhoneNumber.text;
                    if (nam.isNotEmpty && phone.isNotEmpty) {
                      Data nData = Data(nam, phone);
                      BlocProvider.of<TodoCubit>(context).addTodo(nData);
                      cName.clear();
                      cPhoneNumber.clear();
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
