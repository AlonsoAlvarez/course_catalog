import 'package:children_now/components/login/text_field.dart';
import 'package:children_now/models/user.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:children_now/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'button.dart';

class CardRegister extends StatefulWidget {
  final Function showRegister;
  const CardRegister({Key? key, required this.showRegister}) : super(key: key);

  @override
  State<CardRegister> createState() => _CardRegisterState();
}

class _CardRegisterState extends State<CardRegister> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final ctrlConfirmPassword = TextEditingController();

  final nodePassword = FocusNode();
  final nodeConfirmPassword = FocusNode();

  bool showPassword = false;

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    ctrlConfirmPassword.dispose();
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
              "Registro",
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
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(nodeConfirmPassword);
            },
          ),
          TextFieldLogin(
            focusNode: nodeConfirmPassword,
            controller: ctrlConfirmPassword,
            hintText: "Confirm Password",
            obscureText: true,
            textInputType: null,
            suffixIcon: IconButton(
                icon: const Icon(
                   Icons.visibility_off,
                  color: Color(0xFFA1A1A1),
                ),
                onPressed: () {
                  Fluttertoast.showToast(msg: 'No se puede mostrar');
                }),
            onFieldSubmitted: null,
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonLogin(
            function: () async {
              if (ctrlEmail.text.isEmpty || ctrlPassword.text.isEmpty ) {
                Fluttertoast.showToast(msg: 'Datos incorrectos');
              } else {
                if (ctrlPassword.text == ctrlConfirmPassword.text) {
                  User? credential = await AuthService.registerUser(
                      ctrlEmail.text, ctrlPassword.text);
                  if (credential != null) {
                    appState.currentUser = credential;
                    Fluttertoast.showToast(msg: 'Cuenta creada exitosamente.');
                  } else {
                    Fluttertoast.showToast(msg: 'Email invalido');
                  } 
                } else {
                  Fluttertoast.showToast(msg: 'Contraseña incorrecta, favor de validar');
                }
              }
            },
            assetImage: null,
            icon: const Icon(
              Icons.mail,
              color: Colors.white,
              size: 23,
            ),
            title: 'Generar cuenta',
            deviceSize: deviceSize,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    widget.showRegister();
                  },
                  child: const Text('Iniciar sesión')))
        ],
      ),
    );
  }
}
