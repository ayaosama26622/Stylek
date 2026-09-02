class SignInRequestModel {
  const SignInRequestModel({required this.email, required this.password});

  final String email;
  final String password;
}

class SignUpRequestModel extends SignInRequestModel {
  const SignUpRequestModel({
    required this.userName,
    required super.email,
    required super.password,
  });

  final String userName;
}
