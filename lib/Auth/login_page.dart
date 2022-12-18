import '../Component2/Buttons/solid_button.dart';
import '../Component2/Input/input_field.dart';
import '../Util/Colors.dart';
import 'package:flutter/material.dart';
import '../Util/space.dart';
import 'Auth.helper/auth.helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                  top: 80,
                ),
                child: Text(
                  "Hello Again! \nWelcome \nback",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    fontFamily: "Playfair",
                  ),
                ),
              ),
              const VerticalSpace(space: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  label: "Email",
                  hint: "example@email.com",
                  controller: email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  label: "Password",
                  hint: "*******",
                  controller: password,
                  isPassword: true,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: SolidButton(
                  onPressed: () async {
                    Map<String, dynamic> formData = {
                      "email": email.text,
                      "password": password.text,
                    };
                    dynamic res = await loginClient(formData);
                    if (!res) {
                      setState(() {
                        error = true;
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, "/app");
                    }
                  },
                  label: "Login",
                  color: primary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/registration");
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
