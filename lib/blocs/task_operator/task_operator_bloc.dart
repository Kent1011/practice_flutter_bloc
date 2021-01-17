import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice_bloc_n_cubit_v6/services/to_do_service/to_do_service.dart';

part 'task_operator_event.dart';
part 'task_operator_state.dart';

class TaskOperatorBloc extends Bloc<TaskOperatorEvent, TaskOperatorState> {
  TaskOperatorBloc() : super(TaskOperatorInitial());

  @override
  Stream<TaskOperatorState> mapEventToState(
    TaskOperatorEvent event,
  ) async* {
    if (event is CreateTask) {
      yield* this._createTask(event.taskName);
    } else if (event is RemoveTask) {
      yield* this._removeTask(event.id);
    } else if (event is CompleteTask) {
      yield* this._completeTask(event.id);
    }
  }

  Stream<TaskOperatorState> _createTask(String taskName) async* {
    if (state is TaskOperating) return;

    yield TaskOperating();
    await Future.delayed(const Duration(seconds: 1));
    ToDoService.instance.addTask(taskName);
    yield TaskOperateDone();
  }

  Stream<TaskOperatorState> _removeTask(String id) async* {
    if (state is TaskOperating) return;

    yield TaskOperating();
    await Future.delayed(const Duration(seconds: 1));
    ToDoService.instance.remove(id);
    yield TaskOperateDone();
  }

  Stream<TaskOperatorState> _completeTask(String id) async* {
    if (state is TaskOperating) return;

    yield TaskOperating();
    await Future.delayed(const Duration(seconds: 1));
    ToDoService.instance.finishTask(id);
    yield TaskOperateDone();
  }
}
