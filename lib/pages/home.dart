import 'package:children_now/components/home/drawer.dart';
import 'package:children_now/pages/shopping_cart.dart';
import 'package:children_now/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: const Color(0xffCAC4C7),
      appBar: AppBar(
        backgroundColor: const Color(0xff666264),
        title: const Text('Home'),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    if (appState.order != null) {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const PageShoppingCart(
                          ),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: 'No hay productos en el carrito');
                    }
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )),
              if (appState.order != null) ...[
                Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                    ))
              ]
            ],
          )
        ],
      ),
      drawer: const DrawerHome(),
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
