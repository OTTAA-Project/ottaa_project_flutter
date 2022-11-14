class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String? avatar;
  final int? birthdate;
  final String? gender;
  final String? language;
  final bool isFirstTime;

  const UserModel({required this.id, required this.name, required this.email, required this.photoUrl, this.birthdate, this.gender, this.language, this.isFirstTime = true, this.avatar = "617"});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'] ?? 'n/a',
        birthdate: json['birthdate'] ?? 0,
        gender: json['gender'] ?? 'n/a',
        isFirstTime: json['isFirstTime'] == 0 ? false : true,
        language: json['language'] ?? 'es',
        avatar: json['avatar'] ?? "617",
      );

  factory UserModel.fromRemote(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['Nombre'],
        email: json['Email'],
        photoUrl: json['Avatar']['name'] ?? 'n/a',
        birthdate: json['birth_date'] ?? 0,
        gender: json['pref_sexo'] ?? 'n/a',
        isFirstTime: false,
        language: 'es',
        avatar: json['Avatar']['urlFoto'] ?? "617",
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'birthdate': birthdate ?? 0,
        'gender': gender ?? 'n/a',
        'isFirstTime': isFirstTime ? 1 : 0,
        'language': language ?? 'es',
        'avatar': avatar ?? "617",
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
        }
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
    );
  }
}
