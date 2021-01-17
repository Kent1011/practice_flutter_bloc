part of 'task_operator_bloc.dart';

@immutable
abstract class TaskOperatorEvent {
  const TaskOperatorEvent();
}

class CreateTask extends TaskOperatorEvent {
  final String taskName;

  const CreateTask(this.taskName);
}

class RemoveTask extends TaskOperatorEvent {
  final String id;

  const RemoveTask(this.id);
}

class CompleteTask extends TaskOperatorEvent {
  final String id;

  const CompleteTask(this.id);
}
