import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc_n_cubit_v6/blocs/task_operator/task_operator_bloc.dart';
import 'package:practice_bloc_n_cubit_v6/blocs/to_to_list/to_do_list_bloc.dart';
import 'package:practice_bloc_n_cubit_v6/models/to_do.dart';
import 'package:practice_bloc_n_cubit_v6/widgets/to_do_list_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController taskController;

  void _loadList() {
    BlocProvider.of<ToDoListBloc>(context).add(LoadList());
  }

  void _addTask() {
    var taskName = taskController?.text;
    if (taskName?.isNotEmpty ?? false)
      BlocProvider.of<TaskOperatorBloc>(context).add(CreateTask(taskName));
    else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter the task name')));
  }

  void _clearField() {
    taskController.text = '';
  }

  @override
  void didChangeDependencies() {
    taskController ??= TextEditingController();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    if (context.read<ToDoListBloc>().state is ToDoListInitial) {
      this._loadList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: _buildForm(),
        ),
        _buildTasksLayout(),
      ],
    );
  }

  Widget _buildForm() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: taskController,
            decoration: InputDecoration(hintText: 'Please enter to do task'),
          ),
        ),
        BlocConsumer<TaskOperatorBloc, TaskOperatorState>(
          listener: (context, state) {
            if (state is TaskOperateDone) {
              _clearField();
              _loadList();
            } else if (state is TaskOperateError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is TaskOperating) {
              return MaterialButton(onPressed: null, child: Text('Processing'));
            }
            return MaterialButton(onPressed: _addTask, child: Text('Add'));
          },
        ),
      ],
    );
  }

  Widget _buildTasksLayout() {
    return BlocConsumer<ToDoListBloc, ToDoListState>(
      listener: (context, state) {
        if (state is ToDoListLoadFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is ToDoListLoaded) {
          return _buildList(state.tasks);
        } else if (state is ToDoListLoading) {
          return _buildLoader();
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildList(List<ToDo> tasks) {
    return Expanded(
      child: ToDoListWidget(tasks: tasks),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
    );
  }
}
