class User {
  final String firstName;
  final String lastName;
  final String id;
  final String title;
  final String picture;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        picture = json['picture'];
}
