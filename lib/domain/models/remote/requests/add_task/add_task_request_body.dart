class AddTaskRequestBody {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;


  AddTaskRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar
  };
}
