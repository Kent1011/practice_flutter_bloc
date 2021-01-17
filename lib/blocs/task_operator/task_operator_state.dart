part of 'task_operator_bloc.dart';

@immutable
abstract class TaskOperatorState {
  const TaskOperatorState();
}

class TaskOperatorInitial extends TaskOperatorState {
  const TaskOperatorInitial();
}

class TaskOperating extends TaskOperatorState {
  const TaskOperating();
}

class TaskOperateDone extends TaskOperatorState {
  const TaskOperateDone();
}

class TaskOperateError extends TaskOperatorState {
  final String message;

  const TaskOperateError(this.message);
}
