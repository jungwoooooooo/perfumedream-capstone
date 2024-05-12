import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/model_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Item> checkoutList = []; // Initialize an empty list of items
  double totalPrice = 0;

  // Initialize TextEditingController variables
  TextEditingController buyerNameController = TextEditingController();
  TextEditingController buyerEmailController = TextEditingController();
  TextEditingController buyerPhoneController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController receiverZipController = TextEditingController();
  TextEditingController receiverAddress1Controller = TextEditingController();
  TextEditingController receiverAddress2Controller = TextEditingController();
  TextEditingController userPwdController = TextEditingController();
  TextEditingController userConfirmPwdController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController cardAuthController = TextEditingController();
  TextEditingController cardExpiredDateController = TextEditingController();
  TextEditingController cardPwdTwoDigitsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Calculate total price
    for (int i = 0; i < checkoutList.length; i++) {
      totalPrice += checkoutList[i].price * checkoutList[i].quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: checkoutList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return checkoutContainer(
                  item: checkoutList[index],
                );
              },
            ),
            // Add your input form fields here
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            // Handle payment
          },
          child: Text("Pay ${NumberFormat.currency(locale: 'en_US', symbol: '\$').format(totalPrice)}"),
        ),
      ),
    );
  }

  Widget checkoutContainer({required Item item}) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: item.imageUrl,
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const Center(
                child: Text("Error"),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  textScaleFactor: 1.2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${NumberFormat.currency(locale: 'en_US', symbol: '\$').format(item.price)}"),
                Text("Quantity: ${item.quantity}"),
                Text("Total: ${NumberFormat.currency(locale: 'en_US', symbol: '\$').format(item.price * item.quantity)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Add other input form field widgets here
}
