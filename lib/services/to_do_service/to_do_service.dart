import 'package:practice_bloc_n_cubit_v6/models/to_do.dart';

/// Handle tasks C.R.U.D

class ToDoService {
  List<ToDo> _tasks = [];

  ToDoService._instance();

  static final ToDoService _service = ToDoService._instance();

  static ToDoService get instance => _service;

  List<ToDo> getTasks() => _tasks ?? [];

  ToDo getTask(String id) =>
      getTasks().firstWhere((task) => task.id == id, orElse: () => null);

  void addTask(String taskName) => _tasks.add(
      ToDo(DateTime.now().microsecondsSinceEpoch.toString(), taskName, false));

  void remove(String id) => _tasks.removeWhere((task) => task.id == id);

  void finishTask(String id) {
    final index = _tasks.indexWhere((element) => element.id == id);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(isFinished: true);
  }
}
