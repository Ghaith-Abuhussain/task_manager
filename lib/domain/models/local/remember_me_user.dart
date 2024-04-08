import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/constants/strings.dart';

@Entity(tableName: remembermeUserTableName)
class RememberMeUser extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final String password;

  RememberMeUser({required this.id, required this.username, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [id, username, password];

}