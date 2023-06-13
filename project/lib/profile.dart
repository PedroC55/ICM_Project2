import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:homework/editprofile.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'Models/usermodel.dart';

class ProfilePage extends StatefulWidget{  
  @override
  ProfilePageState createState() => ProfilePageState();

}

class ProfilePageState extends State<ProfilePage>{
  String _userName = ""; 
  String name = "";
  int age = 0;
  int nMec = 0;
  int phone = 0;
  String email = "";
  String image = "";
  String password = "";
  String id = "";
  String imageURL = "";
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getUserName();
    });
    super.initState();
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    
    db.settings = const Settings(persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,);
    print(_userName);
   
    
    return Scaffold(
      body: FutureBuilder(
        future: _getUserName(),
        builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              child: GestureDetector(
                child:
                Image.asset(
                  'assets/user.png',
                  fit: BoxFit.cover, // Fixes border issues
                  width: 120.0,
                  height: 120.0,
                )
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
                color: Color(0xFFF4F6F7),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileDetailRow(title: 'Name', value: name),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileDetailRow(title: 'E-mail', value: email),
                        ProfileDetailRow(title: 'Age', value: age.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileDetailRow(title: 'NMEC', value: nMec.toString()),
                        ProfileDetailRow(title: 'Phone Number', value: phone.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 40.0,),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfileWidget()),
                                ), 
              icon: Icon(Icons.edit_rounded, size: 24,),
              label: Text("Edit Profile", style: TextStyle(fontSize: 18),)
            ),
            SizedBox(height: 40.0,),
            ElevatedButton.icon(
              onPressed: () => FirebaseAuth.instance.signOut(), 
              icon: Icon(Icons.send_to_mobile_rounded, size: 24,),
              label: Text("Sign Out", style: TextStyle(fontSize: 18),)
            ),
          ],);
        },
        ),
    );
  }
  _getUserName() async {
    _userName = ((await FirebaseAuth.instance.currentUser()).email);
    final userDoc = await FirebaseFirestore.instance.collection("users").get().then((value){
      value.docs.forEach((element) async {
        if (_userName == element['email']){
          id = element.id.toString();
          name = element['name'];
          email = element['email'];
          password = element['password'];
          age = element['age'];
          nMec = element['nmec'];
          phone = element['phonenumber'];
          image = element['image'];     
        }
      });
      
    });
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      event.docs.forEach((element) {
        if (_userName == element['email']){
          id = element.id.toString();
          name = element['name'];
          email = element['email'];
          password = element['password'];
          age = element['age'];
          nMec = element['nmec'];
          phone = element['phonenumber'];
          image = element['image'];
          setState(() {});
        }
      });
    });

  }

  @override
  void dispose(){
    super.dispose();
  }
  


  Future<void> loadImage() async {
    final imageRef = await FirebaseStorage.instance.ref().child(image);
    try {
      const oneMegabyte = 10240 * 10240;
      final Uint8List? data = await imageRef.getData(oneMegabyte);
      // Data for "images/island.jpg" is returned, use this as needed.~
      print(data);
    } on FirebaseException catch (e) {
      // Handle any errors.
    }
  }

  File? _photo;
  Future imgFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(_photo, pickedFile);
      } else {
        print('No image selected.');
      }
    });
  }
    Future uploadFile(File? _photo, File file) async {
      /*
      final storageRef = FirebaseStorage.instance.ref();
      final profileImageRef = storageRef.child(_photo.toString());
      profileImageRef.putFile(file);*/
      final fileName = basename(_photo!.path);
      
      StorageReference reference = FirebaseStorage.instance.ref().child('file/' + fileName.toString());
      var data = UserModel(name, email, password, age, phone, nMec, 'file/' + fileName.toString());
      FirebaseFirestore.instance.collection("users").doc(id).update(data.toJson());
      StorageUploadTask uploadTask = reference.putFile(file);
        await uploadTask.future.then((res) {
          print(res.downloadUrl);
        });
      Uri location = (await uploadTask.future).downloadUrl;
      

  }  
}
class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Color(0xFF313131),
                      fontSize: 9.0,
                    ),
              ),
              SizedBox(
                height: 20.0 / 2,
              ),
              Text(value, style: Theme.of(context).textTheme.caption),
              SizedBox(
                height: 20.0 / 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Color(0xFF313131),
                      fontSize:11.0,
                    ),
              ),
              SizedBox(
                height: 20.0 / 2,
              ),
              Text(value, style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.black,
                fontSize:11.0,
              )),
              SizedBox(
                height: 20.0 / 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}