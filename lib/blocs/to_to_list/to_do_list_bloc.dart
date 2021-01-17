import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice_bloc_n_cubit_v6/models/to_do.dart';
import 'package:practice_bloc_n_cubit_v6/repositories/to_do_list_repository.dart';

part 'to_do_list_event.dart';
part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  final ToDoListRepository repository;

  ToDoListBloc(this.repository) : super(ToDoListInitial());

  @override
  Stream<ToDoListState> mapEventToState(
    ToDoListEvent event,
  ) async* {
    if (event is LoadList) {
      yield* this._mapFetchListStates();
    }
  }

  Stream<ToDoListState> _mapFetchListStates() async* {
    if (state is ToDoListLoading) return;

    yield ToDoListLoading();

    try {
      final tasks = await repository.fetchAllToDo();
      yield ToDoListLoaded(tasks);
    } catch (error) {
      print(error);
      yield ToDoListLoadFailed('Fetch tasks failed.');
    }
  }
}
