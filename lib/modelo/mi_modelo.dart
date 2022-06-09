

class MiModelo {
  String? UserName;
  String? Password;
  String? Level;

  MiModelo(this.UserName, this.Password, this.Level);

  MiModelo.vacio();

  MiModelo.fromJson(Map<String, dynamic> json)
      : UserName = json['UserName'],
        Password = json['Password'],
        Level = json['Level'];

  Map<String, dynamic> toJson() {
    return {
      'UserName': UserName,
      'Password': Password,
      'Level': Level,
    };
  }

}