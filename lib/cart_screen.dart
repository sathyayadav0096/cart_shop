import 'package:flutter/material.dart';
import 'models/product_model.dart';

class CartScreen extends StatefulWidget {
  final List<Product> items;

  const CartScreen({Key? key, required this.items}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void increaseQuantity(int index) {
    setState(() {
      widget.items[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (widget.items[index].quantity > 1) {
        widget.items[index].quantity--;
      }
    });
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (Product product in widget.items) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  double calculateGST() {
    double totalPrice = calculateTotalPrice();
    return totalPrice * 0.18; // Assuming GST is 18%
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context, widget.items);
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true, // non scrolling items will scroll
        itemBuilder: (context, index) {
          Product product = widget.items[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 80,
                      width: 90,
                      child: Image.network(product.thumbnail),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton( // incremental and decremental
                                icon: const Icon(Icons.remove),
                                onPressed: () => decreaseQuantity(index),
                              ),
                              Text(
                                product.quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => increaseQuantity(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${product.rating}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(height: 12),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                        onPressed: () {
                          if (widget.items.length > 1) {
                            setState(() {
                              widget.items.removeAt(index);
                            });
                          } else {
                            setState(() {
                              widget.items.removeAt(index);
                            });
                            Navigator.pop(context, widget.items);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Items Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'GST (18%): \$${calculateGST().toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Price (incl. GST): \$${(calculateTotalPrice() + calculateGST()).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
