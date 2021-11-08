import 'package:getx_database/Database/UserDAO.dart';

class User {
  int? id;
  String? contact;
  String? name;

  User(this.name, this.contact);

  Map<String, dynamic> toMap() {
    return {
      UserDAO.ID: id,
      UserDAO.NAME: name,
      UserDAO.CONTACT: contact,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map[UserDAO.ID],
        name = map[UserDAO.NAME],
        contact = map[UserDAO.CONTACT];

  @override
  String toString() {
    return "User(id: $id, name: $name,contact: $contact,)";
  }
}
