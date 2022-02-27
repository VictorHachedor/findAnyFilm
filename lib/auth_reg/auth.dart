//Login Sign Up green color
import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  get height => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: FilmTheme.backgroundColor,
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Column(children: [
                        buildTextFormFieldEmail(
                            'Email address',
                            'Email address',
                            'Enter correct email',
                            '*Required'),
                        buildTextFormFieldPassword('Password', 'Password',
                            'Enter correct password', '*Required'),
                      ])),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Forgot your password?',
                          style: TextStyle(
                              color: FilmTheme.acidGreenColor,                             
                              fontSize: 17.0))),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(300.0, 50.0),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO: Event happening while the button clicked
                      }                      
                    },
                    child: const Text('Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          color: Colors.black,
                        )),
                  ),
                ],
              )),
        ));
  }

  Widget buildTextFormFieldEmail(
      String textHint, String labelText, String warningText, String emptyText) {
    return TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.white,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          hintText: textHint,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintStyle: TextStyle(color: Colors.grey[800]),
        ),
        cursorColor: Colors.white,
        cursorHeight: 30.0,
        cursorWidth: 1.0,
        validator: (String? value) {
          if (value!.isEmpty) {
            return '*Required';
          } else if (!RegExp(r"^^(?=.{1,81}$)[\w\.-]+@[\w\.-]+\.\w{2,4}$")
              .hasMatch(value)) {
            return warningText;
          }
        });
  }

  Widget buildTextFormFieldPassword(
      String textHint, String labelText, String warningText, String emptyText) {
    return TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          hintText: textHint,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey[800]),
          labelStyle: const TextStyle(color: Colors.grey),
        ),
        cursorColor: Colors.white,
        cursorHeight: 30.0,
        cursorWidth: 1.0,
        validator: (String? value) {
          if (value!.isEmpty) {
            return '*Required';
          } else if ((value.length > 7) &&
              (value.length < 30) &&
              (RegExp(r"[a-z.]").hasMatch(value)) &&
              (RegExp(r"[A-Z.]").hasMatch(value)) &&
              (RegExp(r"[0-9.]").hasMatch(value)) &&
              (RegExp(r"[@$!%*?&.]").hasMatch(value))) {
            return null;
          } else {
            return warningText;
          }
        });
  }
}
