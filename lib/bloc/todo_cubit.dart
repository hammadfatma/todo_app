import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_state.dart';
import 'package:todo_app_bloc/models/data.dart';

class TodoCubit extends Cubit<TodoState>{
  TodoCubit():super(InitState());

  static TodoCubit get(context) => BlocProvider.of(context);
  List<Data> data = [];
  //int get numData => data.length;
  void addTodo(Data newData){
    data.add(newData);
    emit(AddTodoStatueSuccess());
  }
  String getName(int dataIndex){
    return data[dataIndex].name;
  }
  String getPhone(int dataIndex){
    return data[dataIndex].phoneNumber;
  }
  void deleteTodo(int dataIndex){
    data.removeAt(dataIndex);
    emit(RemoveTodoStatueSuccess());
  }
}