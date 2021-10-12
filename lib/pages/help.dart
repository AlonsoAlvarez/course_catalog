import 'package:children_now/components/help/card_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'contact.dart';

class PageHelp extends StatelessWidget {
  const PageHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Ayuda'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          ...Questions.map((e) => CardQuestion(
                question: e,
              )),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) => const PageContact(),
                  ),
                );
              },
              child: const Text(
                'Contactar administrador',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
