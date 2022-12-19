import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:pos/screens/product_list.dart';

import '../utils/shared_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  // final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  void login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse('http://192.168.1.31:8080/login'),
          body: {
            'username': username,
            'password': password
          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['access_token']);
        setState(() => loading = true);
        ConstantSharedPreference.preferences!.setBool("loggedIn", true);
        ConstantSharedPreference.preferences?.setString(
            'Token', data['access_token']);
        // print('Account Created Successfully');
        print('Log In Successfully');
        setState(() {
          loading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("LogIn Successfully")));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductList()));
      } else {
        print("Failed");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Enter Correct Email & Password")));
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                children: [
            Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Form(
                key: _formKey,
                child: Column(
                  children: [
                  const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              fontFamily: 'Lemon',
                              color: Colors.white)
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "You Have Been Missed!",
                        style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Email ',
                    hintStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),

                    prefixIcon: const Icon(Icons.email_outlined,
                    color: Colors.blue,),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty || !value.contains('@')  || !value
                //       .contains('.') ! ||
                //   value.endsWith('.com')
                //   ){
                //   return 'Enter a Valid Email Address';
                //   }
                //   return
                //   null;
                // },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordController,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    // borderSide: const BorderSide(color: Colors.white)
                  ),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.blue,),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Password';
                } else if (value
                    .toString()
                    .length < 6) {
                  return "Password is too small";
                } else {
                  return null;
                }
              },
            ),
            ],
          )),
      const SizedBox(
        height: 50,
      ),
      MaterialButton(
        child: const Text("Login"),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            login(emailController.text.toString(),
                passwordController.text.toString());
          } else {
            return null;
          }
        },
      ),
      const SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const ForgotPasswordScreen()));
          },
          child: const Text('Forget password?'),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have account?",
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          TextButton(
            onPressed: () {
            },
            child: const Text('SignUp'),
          )
        ],
      ),
      ],
    ),
    ),
    ),
    ],
    ),
    )
    ),
    // ),
    );
  }
}