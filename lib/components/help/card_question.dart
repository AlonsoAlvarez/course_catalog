import 'package:children_now/models/question.dart';
import 'package:children_now/pages/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardQuestion extends StatelessWidget {
  final Question question;
  const CardQuestion({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        question.question,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        question.answer,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push<void>(
                              context,
                              CupertinoPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const PageContact(),
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
                ),
              );
            });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            question.question,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
