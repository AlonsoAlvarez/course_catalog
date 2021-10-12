import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatefulWidget {
  final Function function;
  final String title;
  final String? assetImage;
  final Icon? icon;
  final Size deviceSize;
  const ButtonLogin({
    Key? key,
    required this.function,
    required this.title,
    required this.assetImage,
    required this.icon,
    required this.deviceSize,
  }) : super(key: key);

  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.deviceSize.width / 2,
      height: widget.deviceSize.width < widget.deviceSize.height
          ? widget.deviceSize.height / 18
          : widget.deviceSize.height / 8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Colors.black,
                  )),
              primary: isLoading ? Colors.grey[350] : Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 8)),
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
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (widget.assetImage != null) ...[
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(widget.assetImage!),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ] else ...[
                          widget.icon!
                        ],
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ))),
    );
  }
}