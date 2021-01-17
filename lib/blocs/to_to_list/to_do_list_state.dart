part of 'to_do_list_bloc.dart';

@immutable
abstract class ToDoListState {
  const ToDoListState();
}

class ToDoListInitial extends ToDoListState {
  const ToDoListInitial();
}

class ToDoListLoading extends ToDoListState {
  const ToDoListLoading();
}

class ToDoListLoaded extends ToDoListState {
  final List<ToDo> tasks;

  const ToDoListLoaded(this.tasks);
}

class ToDoListLoadFailed extends ToDoListState {
  final String message;

  const ToDoListLoadFailed(this.message);
}
