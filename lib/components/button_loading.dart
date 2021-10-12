import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLoading extends StatefulWidget {
  final Function function;
  final String title;
  const ButtonLoading({Key? key, required this.function, required this.title}) : super(key: key);

  @override
  _ButtonLoadingState createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(
                    color: Colors.black,
                  )),
              primary: isLoading ? Colors.grey[350] : Colors.black,),
          onPressed: () async {
            if (!isLoading) {
              setState(() => isLoading = true);
              await widget.function();
              setState(() => isLoading = false);
            }
          },
          child: Center(
              child: isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))),
    );
  }
}
