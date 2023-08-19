import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/view/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:math';

signupSerivces(
    String userName, String useremail, String userdob, String userPassword) 
    async{
  User? userId = FirebaseAuth.instance.currentUser;
  
  try{
    FirebaseFirestore.instance.collection('SignupUsers').doc(userId!.uid).set({
    'userEmail': useremail,
    'userName': userName,
    'userdob': userdob,
    'userPassword':userPassword,
    'userTime': DateTime.now(),
    'userId': userId.uid,
  },).then((value) => {
    FirebaseAuth.instance.signOut(),
    Get.to(()=>Signin())
  });
  } 
  on FirebaseAuthException catch(e){
    print(e);
  }
}

siginServices(String siginMail, String siginPassword){
  

}
