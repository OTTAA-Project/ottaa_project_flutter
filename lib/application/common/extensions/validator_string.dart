extension ValidatorString on String {
  bool get isEmail {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(this);
  }

  bool get isPassword {
    final RegExp regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(this);
  }
}
