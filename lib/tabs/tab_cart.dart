import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/model_cart.dart';

class TabCart extends StatelessWidget {
  late String uid = '';

  Future<void> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    getUid();
    return Scaffold(
      appBar: AppBar(
        title: Text('장바구니'),
      ),
      body: FutureBuilder(
        future: cartProvider.fetchCartItemsOrCreate(uid),
        builder: (context, snapshot) {
          if (cartProvider.cartItems.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                        arguments: cartProvider.cartItems[index]);
                  },
                  title: Text(cartProvider.cartItems[index].title),
                  subtitle: Text(cartProvider.cartItems[index].price.toString()),
                  leading: Image.network(cartProvider.cartItems[index].imageUrl),
                  trailing: InkWell(
                    onTap: () {
                      cartProvider.removeCartItem(uid, cartProvider.cartItems[index]);
                    },
                    child: Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
      //결제 하러가기 버튼      // bottomNavigationBar: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: FilledButton(
      //       onPressed: () {
      //         Navigator.pushNamed(
      //           context,
      //           '/checkout',
      //           arguments: totalPrice,
      //         );
      //       },
      //       child: Text("총 ${numberFormat.format(totalPrice)}원 결제하기"),
      //     )),


    );
  }
}
