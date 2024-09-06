import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
 
   const LoginPage({
    super.key, 
    required this.onTap,

    });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign in user method
  void signUserIn() async{


    //show loading circle
    showDialog(
      context: context,
       builder: (context) {
        return const Center(  
          child: CircularProgressIndicator(),
        ) ;
       }
      );



    try{await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {

            Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
     
    }

      

  }


  //error message to user
  void showErrorMessage(String message) {

    showDialog(
      context: context,
       builder: (context) {
        return  AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
            child: Text(
            message,
            style: const TextStyle(color: Colors.white),
              ),
          ),
        );
       }
      );
  }


  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.only(right: 400, left: 400),
          child: SizedBox(     
            width: double.infinity,
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    'lib/assets/images/knuts.jpg', // Provide your image path here
                    height: 200,
                    width: 350,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Welcome to Knutsford calorie tracker! Please sign in to continue.',
                    style: TextStyle(color: Colors.black,fontSize: 20),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: TextButton(
                      onPressed: () {     
                                   // Action for Register button
                      },
                      child: const Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(color: Colors.blue,fontSize: 19),
                        
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 60,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 4.0),
                        ),
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 60,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 4.0),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      // Action for Forgot password button
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),
                ),
                    
                const SizedBox(height: 20),
                    
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
             onPressed: () {
               // Call the signUserIn method here
            signUserIn();   
                },
              style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(),
              backgroundColor: Colors.white70,                 
             ),
            child: const Text(
            'Sign in ',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            ),
            ),
               ), 
                    
                                 
                const SizedBox(height: 25),

                SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
               onPressed: () {
      // Action for the button
                },
              style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(),
              backgroundColor: Colors.lightBlue,
          ),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
             Image.asset(
               'lib/assets/images/gogo.png', // Path to the image
                  width: 40, // Set width of the image
            height: 40, // Set height of the image
             ),
           const SizedBox(width: 10), // Add space between image and text
            const Text(
           'Sign in with Google',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
           ],
         ),
        ),
       ),

                    
                
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
