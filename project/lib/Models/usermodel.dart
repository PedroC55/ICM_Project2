class UserModel{
  late String name;
  late String email;
  late String password;
  late int age;
  late int phonenumber;
  late int nmec;
  late String image;

  UserModel(String name, String email, String password, int age, int phonenumber, int nmec, String image){
    this.name = name;
    this.email = email;
    this.password = password;
    this.age = age;
    this.phonenumber = phonenumber;
    this.nmec = nmec;
    this.image = image;
  }

  toJson(){
    return{
      "name" : name,
      "email": email,
      "password": password,
      "age":age,
      "phonenumber":phonenumber,
      "nmec":nmec, 
      "image":image,
    };
  }

}