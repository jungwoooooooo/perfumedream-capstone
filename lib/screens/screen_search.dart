// screens/screen_search.dart
import 'package:flutter/material.dart';
import 'package:kkk_shop/models/model_product_provider.dart';
import 'package:provider/provider.dart';

import '../models/model_query.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final queryProvider = Provider.of<QueryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            TextField(
              onChanged: (text) {
                queryProvider.updateText(text);
              },
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'search keyword',
                border: InputBorder.none,
              ),
              cursorColor: Colors.grey,
            )
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                productProvider.search(queryProvider.text);
              },
              icon: Icon(Icons.search_rounded))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemCount: productProvider.searchProduct.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail',
                                arguments: productProvider.searchProduct[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(productProvider.searchProduct[index].productImageUrl ?? ''),
                                Text(
                                  productProvider.searchProduct[index].productName ?? '',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  productProvider.searchProduct[index].price.toString() + '원',
                                  style: TextStyle(fontSize: 16, color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ));
                  }))
        ],
      ),
    );
  }
}