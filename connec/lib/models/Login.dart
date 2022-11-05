class Login {
  final int user_id;
  final String user_account;
  final String user_password;
  final String user_name;
  final int user_authority;
  final String social_login_id;
  final String social_login_secret;
  final String access_token;

  Login(
      {
        required this.user_id,
        required this.user_account,
        required this.user_password,
        required this.user_name,
        required this.user_authority,
        required this.social_login_id,
        required this.social_login_secret,
        required this.access_token
      });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      user_id: json['user_id'],
      user_account: json['user_account'],
      user_password: json['user_password'],
      user_name: json['user_name'],
      user_authority: json['user_authority'],
      social_login_id: json['social_login_id'],
      social_login_secret: json['social_login_secret'],
      access_token: json['access_token'],
    );
  }
}