import 'package:flutter/material.dart';

class DividerLogin extends StatelessWidget {
  const DividerLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: const [
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text('OR'),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Divider(
            color: Colors.black,
            thickness: 1.5,
          ))
        ],
      ),
    );
  }
}