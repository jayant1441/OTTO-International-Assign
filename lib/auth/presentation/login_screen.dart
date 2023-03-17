import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otto_international_assign/utils/colors.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import '../../home_page/presentation/home_page_index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Image.asset("assets/otto_image.jpg", width: 100,),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("OTTO International", style: TextStyle(fontWeight: FontWeight.w900 ,fontSize: 25, letterSpacing: 5),),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text("Please login to otto international"),
                      const SizedBox(
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: SignInButton(
                            buttonType: ButtonType.google,
                            shape: const RoundedRectangleBorder(

                            ),
                            elevation: 0,
                            onPressed: () {
                              googleSignInFunction(context);
                            }),
                      ),

                      const SizedBox(height: 20,),

                    ],
                  ),
                ),

              ],
            ),
          ),
          TextButton(onPressed: (){
            showDialog(context: context, builder: (_){
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Jayant Dhingra"),
                      Text("+91 8950812364"),
                      Text("jayantdhingra1441@gmail.com")
                    ],
                  ),
                ),
              );
            });
          }, child: const Text("Contact Developer", style: TextStyle(color: AppColors.goldColor),)),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }


  Future<void> googleSignInFunction(BuildContext context) async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userDetails = await FirebaseAuth.instance.signInWithCredential(credential);
      if(userDetails.user?.email != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (_) {
              return const MyHomePage();
            }), (route) => false);
      }
    }
    catch(E){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$E")));
    }
  }
}
