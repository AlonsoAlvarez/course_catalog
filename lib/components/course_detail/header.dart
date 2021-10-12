import 'package:children_now/models/course.dart';
import 'package:flutter/material.dart';

class HeaderProduct extends StatelessWidget {
  final Course course;
  const HeaderProduct({Key? key, required this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Hero(
          tag: course.reference.id,
          child: Image.network(
            course.photo,
            width: size.width,
            height: size.width,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 27,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )), /*
        Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (orderState.getOrder != null) {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PageResumeOrder(
                          comments: orderState.getOrder!.comments,
                          restaurant: orderState.getOrder!.restaurant!,
                        ),
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: 'No hay productos en el carrito');
                  }
                },
              ),
            )), 
        if (orderState.getOrder != null) ...[
          Positioned(
              top: 9,
              right: 9,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
              ))
        ] */
      ],
    );
  }
}