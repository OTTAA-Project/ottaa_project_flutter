class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  //todo: emir check it if it is right or not (-d-)
  final String? lastName;
  final String? avatar;
  final int? birthdate;
  final String? gender;
  final String? language;
  final bool isFirstTime;

  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.photoUrl,
      this.birthdate,
      this.gender,
      this.language,
      this.isFirstTime = true,
      this.lastName,
      this.avatar = "617"});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'] ?? 'n/a',
      birthdate: json['birthdate'] ?? 0,
      gender: json['gender'] ?? 'n/a',
      isFirstTime: json['isFirstTime'] == 0 ? false : true,
      language: json['language'] ?? 'es_AR',
      avatar: json['avatar'] ?? "617",
      lastName: json['last_name'] ?? "n/a");

  factory UserModel.fromRemote(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['Nombre'],
      email: json['Email'],
      photoUrl: json['Avatar']['name'] ?? 'n/a',
      birthdate: json['birth_date'] ?? 0,
      gender: json['pref_sexo'] ?? 'n/a',
      isFirstTime: false,
      language: 'es_AR',
      avatar: json['Avatar']['urlFoto'] ?? "617",
      lastName: json['last_name'] ?? 'n/a');

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'birthdate': birthdate ?? 0,
        'gender': gender ?? 'n/a',
        'isFirstTime': isFirstTime ? 1 : 0,
        'language': language ?? 'es_AR',
        'avatar': avatar ?? "617",
        'lastName': lastName ?? "n/a",
      };

  Map<String, dynamic> toRemote() => {
        'id': id,
        'Nombre': name,
        'Email': email,
        'birth_date': birthdate ?? 0,
        'pref_sexo': gender ?? 'n/a',
        'Avatar': {
          'name': photoUrl,
          'urlFoto': avatar ?? "617",
        },
        'last_name': lastName ?? 'n/a'
      };

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    int? birthdate,
    String? gender,
    String? language,
    bool? isFirstTime,
    String? avatar,
    String? lastName,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      language: language ?? this.language,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      avatar: avatar ?? this.avatar,
      lastName: lastName ?? this.lastName,
    );
  }
}
