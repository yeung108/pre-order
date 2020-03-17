class LoginModel {
  final String token;

  LoginModel(this.token);

  LoginModel.fromJson(Map<String, dynamic> json)
      : token = json['token'];

  Map<String, dynamic> toJson() =>
    {
      'token': token
    };
}

class User {
  final String username;
  final String admin_type;
  final String name;
  final String email;
  final String vendor;
  final bool read_only;
  final String _id;
 
  User(this.username, this.admin_type, this.name, this.email, this.vendor, this.read_only, this._id);

  User.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      admin_type = json['admin_type'],
      name = json['name'],
      email = json['email'],
      vendor = json['vendor'],
      read_only = json['read_only'],
      _id = json['_id'];

  Map<String, dynamic> toJson() =>
    {
      'username': username,
      'admin_type': admin_type,
      'name': name,
      'email': email,
      'vendor': vendor,
      'read_only': read_only,
      '_id': _id
    };
}