//TODO  login and signup buttons toggle
// TODO when all fields are filled out correctly the button turns green
import 'package:flutter/material.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  bool _checkedTerms = false;
  bool _checkedEmails = false;
  get height => null;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 10, 20, 0.9),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Column(children: [
                        buildTextFormFieldName(
                            'Username',
                            'Username',
                            '*Invalid username. Only alphabetical, numeric and single hyphen characters',
                            '*Required'),
                        buildTextFormFieldEmail(
                            'Email address',
                            'Email address',
                            'Enter correct email',
                            '*Required'),
                        buildTextFormFieldPassword(
                            'Password',
                            'Password',
                            '*Password must be between 8 and 30 characters.\n Must include at least 1 uppercase letter.\n Must include at least 1 lowercase letter.\n Must include at least 1 number.\n Must include at least 1 of the following special \n characters @\$!%*?&',
                            '*Required'),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text.rich(
                          TextSpan(
                              //TODO 2 links:  Terms & Conditions and Privacy Policy
                              text: 'By registering you are agreeing to our',
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Terms & Conditions',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text:
                                        ' and acknowledging that you have read our'),
                                TextSpan(
                                    text: ' Privacy Policy.',
                                    style: TextStyle(color: Colors.white))
                              ]),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    buildCheckboxTerms(),
                                    Expanded(
                                      child: _checkedTerms
                                          ? const Text(
                                              '*You confirm you have read and agree to the Terms and Conditions',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          : const Text(
                                              '*Please click the tick box to indicate you have read and agree to the Terms and Conditions',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    buildCheckboxEmails(),
                                    Expanded(
                                        child: _checkedEmails
                                            ? const Text(
                                                '*You would like to receive promotional emails from FindAnyFilm',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : const Text(
                                                '*Please click the tick box if you would like to receive promotional emails from FindAnyFilm',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ))
                                  ],
                                )
                              ],
                            ))
                      ])),
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey,
                        )),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO: Event happening while the button clicked
                      }
                    },
                    child: const Text('Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
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
          } else if (!RegExp(r"^^(?=.{1,81}$)[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,4}$")
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
          } else if ((RegExp(r"[a-z.]").hasMatch(value)) &&
              (RegExp(r"[A-Z.]").hasMatch(value)) &&
              (RegExp(r"[0-9.]").hasMatch(value)) &&
              (RegExp(r"[@$!%*?&.]").hasMatch(value)) &&
              (RegExp(r"^[a-zA-Z0-9@$!%*?&_-]{6,18}$").hasMatch(value))) {
            return null;
          } else {
            return warningText;
          }
        });
  }

  Widget buildTextFormFieldName(
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
          } else if ((RegExp(r"^[a-zA-Z0-9-_]{3,16}$").hasMatch(value))) {
            return null;
          } else {
            return warningText;
          }
        });
  }

  Widget buildCheckboxTerms() {
    return Checkbox(
      value: _checkedTerms,
      onChanged: (value) {
        setState(() {
          _checkedTerms = value!;
        });
      },
      activeColor: Colors.white,
      checkColor: Colors.green,
      fillColor: MaterialStateProperty.all<Color>(Colors.white),
    );
  }

  Widget buildCheckboxEmails() {
    return Checkbox(
      value: _checkedEmails,
      onChanged: (value) {
        setState(() {
          _checkedEmails = value!;
        });
      },
      activeColor: Colors.white,
      checkColor: Colors.green,
      fillColor: MaterialStateProperty.all<Color>(Colors.white),
    );
  }
}
