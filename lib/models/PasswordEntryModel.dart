class PasswordEntryModel {
  final String title;
  final String username;
  final String url;
  final String password;
  final String encryptedPassword;
  final String id;
  final String iv;

  PasswordEntryModel({
    required this.id,
    required this.title,
    required this.username,
    required this.url,
    required this.password,
    required this.encryptedPassword,
    required this.iv,
  });
}
