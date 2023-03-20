class SignUpBody {
  String _name, _password,_repassword;
  SignUpBody({required name, required password, required repassword}) : _name=name, _password=password ,_repassword = repassword;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] = this._name;
    data["password"] = this._password;
    data["repassword"] = this._repassword;
    return data;
  }
}