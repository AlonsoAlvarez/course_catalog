import 'package:children_now/components/login/text_field.dart';
import 'package:children_now/models/user.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:children_now/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'alert_send_password.dart';
import 'button.dart';
import 'divider.dart';

class CardLogin extends StatefulWidget {
  final Function showRegister;
  const CardLogin({Key? key, required this.showRegister}) : super(key: key);

  @override
  State<CardLogin> createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();

  final nodePassword = FocusNode();

  bool showPassword = false;

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    Size deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
            ),
          ),
          TextFieldLogin(
            focusNode: null,
            controller: ctrlEmail,
            hintText: "Email",
            obscureText: false,
            suffixIcon: null,
            textInputType: TextInputType.emailAddress,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(nodePassword);
            },
          ),
          TextFieldLogin(
            focusNode: nodePassword,
            controller: ctrlPassword,
            hintText: "Password",
            obscureText: !showPassword,
            textInputType: null,
            suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFFA1A1A1),
                ),
                onPressed: () {
                  setState(() => showPassword = !showPassword);
                }),
            onFieldSubmitted: null,
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonLogin(
            function: () async {
              if (ctrlEmail.text.isEmpty || ctrlPassword.text.isEmpty) {
                Fluttertoast.showToast(msg: 'Datos incorrectos');
              } else {
                User? credential = await AuthService.signInWhitEmailAndPassword(
                    ctrlEmail.text, ctrlPassword.text);
                if (credential != null) {
                  appState.currentUser = credential;
                } else {
                  Fluttertoast.showToast(msg: 'No logrado');
                }
              }
            },
            assetImage: null,
            icon: const Icon(
              Icons.mail,
              color: Colors.white,
              size: 23,
            ),
            title: 'Iniciar sesión',
            deviceSize: deviceSize,
          ),
          const SizedBox(
            height: 16,
          ),
          const DividerLogin(),
          const SizedBox(height: 15),
          ButtonLogin(
            function: () async {
              User? credential = await AuthService.signInWithGoogle();
              if (credential != null) {
                appState.currentUser = credential;
              } else {
                Fluttertoast.showToast(msg: 'No logrado');
              }
            },
            assetImage: 'assets/google.png',
            icon: null,
            title: 'Sign in whit Google',
            deviceSize: deviceSize,
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertSendPassword();
                          });
                    },
                    child: const Text('¿Olvidatste tu contraseña?')),
                const Spacer(),
                InkWell(
                    onTap: () {
                      widget.showRegister();
                    },
                    child: const Text('Crear cuenta'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
