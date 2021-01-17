import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc_n_cubit_v6/blocs/task_operator/task_operator_bloc.dart';
import 'package:practice_bloc_n_cubit_v6/blocs/to_to_list/to_do_list_bloc.dart';
import 'package:practice_bloc_n_cubit_v6/pages/to_do_page.dart';
import 'package:practice_bloc_n_cubit_v6/repositories/to_do_list_repository.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ToDoListBloc>(
              create: (context) => ToDoListBloc(ServiceToDoListRepository())),
          BlocProvider<TaskOperatorBloc>(
              create: (context) => TaskOperatorBloc()),
        ],
        child: ToDoPage(),
      ),
    );
  }
}
