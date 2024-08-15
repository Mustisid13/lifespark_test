extension StringExtensions on String? {
  // extension for validating email
  bool get isValidEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this ?? "");
  }

  String? get rupee {
    return "₹$this";
  }
}
