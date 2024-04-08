import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventDisplayData extends HomeEvent {
  const HomeEventDisplayData();
}

class HomeEventGetPage extends HomeEvent {
  final int pageNumber;

  const HomeEventGetPage(this.pageNumber);
}

class HomeEventGetNewPage extends HomeEvent {
  const HomeEventGetNewPage();
}

class HomeEventEditTask extends HomeEvent {
  final int taskNumber;
  final String email;
  final String firstName;
  final String lastName;

  const HomeEventEditTask({
    required this.taskNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class HomeEventDeletingTask extends HomeEvent {
  final int taskNumber;

  const HomeEventDeletingTask(this.taskNumber);
}

class HomeEventAddingTask extends HomeEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  const HomeEventAddingTask({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });
}
