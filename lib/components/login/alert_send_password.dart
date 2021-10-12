import 'package:children_now/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertSendPassword extends StatelessWidget {
  AlertSendPassword({Key? key}) : super(key: key);

  final _emailRecuparar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Olivdaste tu contraseña?'),
      content: TextField(
        controller: _emailRecuparar,
        decoration: const InputDecoration(labelText: 'EMAIL'),
      ),
      actions: <Widget>[
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: () async {
              if (_emailRecuparar.text != '') {
                bool result =
                    await AuthService.resetPassword(_emailRecuparar.text);
                Navigator.pop(context);
                if (result) {
                  Fluttertoast.showToast(
                      msg: 'Link enviado a ${_emailRecuparar.text}');
                } else {
                  Fluttertoast.showToast(msg: 'El correo no existe');
                }
              } else {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: 'Email no valido');
              }
            },
            icon: const Icon(Icons.send),
            label: const Text(
              'Enviar email',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
