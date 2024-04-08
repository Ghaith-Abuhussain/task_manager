class EditTaskRequestBody {
  final String firstName;
  final String lastName;
  final String email;


  EditTaskRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
  };
}
