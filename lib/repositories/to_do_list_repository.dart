import 'package:practice_bloc_n_cubit_v6/models/to_do.dart';
import 'package:practice_bloc_n_cubit_v6/services/to_do_service/to_do_service.dart';

abstract class ToDoListRepository {
  Future<List<ToDo>> fetchAllToDo();
}

/// Using mocking data
class MockToDoListRepository implements ToDoListRepository {
  Future<List<ToDo>> fetchAllToDo() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ToDo('1', 'Sample Task', false),
      ToDo('2', 'Sample Task2', true),
    ];
  }
}

/// Using fake service.
class ServiceToDoListRepository implements ToDoListRepository {
  @override
  Future<List<ToDo>> fetchAllToDo() async {
    await Future.delayed(const Duration(seconds: 1));
    return ToDoService.instance.getTasks();
  }
}
