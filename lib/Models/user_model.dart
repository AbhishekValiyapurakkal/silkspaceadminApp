class UserModel {
  final String name;
  final String email;
  final String password;
  final String image;
  final List<String>? productId;

  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.image,
      this.productId});
}
