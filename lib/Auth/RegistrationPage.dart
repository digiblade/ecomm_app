import 'package:ecommerce/Auth/Auth.helper/Auth.helper.dart';

import '../Component2/Buttons/SolidButton.dart';
import '../Component2/Input/InputField.dart';
import '../Util/Colors.dart';
import 'package:flutter/material.dart';
import '../Util/Space.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  bool error = false;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
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
                  top: 60,
                ),
                child: Text(
                  "Hello buddy! \nPlease \nRegister yourself",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: "Playfair",
                  ),
                ),
              ),
              const VerticalSpace(space: 8),
              if (error)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const VerticalSpace(space: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  label: "Name",
                  hint: "",
                  controller: name,
                ),
              ),
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
                  label: "Contact",
                  hint: "+xx-xxxxx xxxxx",
                  controller: contact,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  label: "Password",
                  hint: "*******",
                  isPassword: true,
                  controller: password,
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
                      "fullname": name.text,
                      "password": password.text,
                      "contact": contact.text
                    };
                    dynamic res = await registerClient(formData);
                    if (res == false) {
                    } else {
                      if (res['response'] == false) {
                        setState(() {
                          error = true;
                          errorMessage = res['error'] ?? "Something went wrong";
                        });
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, "/login");
                      }
                    }
                  },
                  label: "Register",
                  color: secondary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "Log In",
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
