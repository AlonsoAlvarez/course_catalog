import 'package:flutter/material.dart';

class AlertConfirm extends StatelessWidget {
  final String title;
  final Function acept;
  final Function cancel;

  const AlertConfirm(
      {Key? key,
      required this.title,
      required this.acept,
      required this.cancel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 25.0),
        textAlign: TextAlign.center,
      ),
      content: Row(
        children: <Widget>[
          Expanded(
              child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              acept();
            },
            icon: const Icon(Icons.check),
            label: const Text('Sí',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic)),
            style: ElevatedButton.styleFrom(primary: Colors.blueGrey[200]),
          )),
          const SizedBox(width: 5.0),
          Expanded(
              child: ElevatedButton.icon(
            onPressed: () {
              cancel();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            label: const Text('No',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic)),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent[200]),
          ))
        ],
      ),
    );
  }
}