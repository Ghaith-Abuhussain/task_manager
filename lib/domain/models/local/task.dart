import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:task_managing/utils/constants/strings.dart';

@Entity(tableName: taskTableName)
class Task extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Task({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
