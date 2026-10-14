enum SignupField {
  firstName("first_name"),
  lastName("last_name"),
  username("username"),
  email("email"),
  password("password");

  const SignupField(this.apiKey);

  final String apiKey;
}
