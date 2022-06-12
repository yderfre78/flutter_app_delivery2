import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ClientProductsDetailPage extends StatelessWidget {
  Product? product;

  ClientProductsDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Container(height: 100, child: _buttonsAddToCart(context)),
      body: Column(
        children: [
          _imageSlideShow(context),
          _textTitle(),
          _textDescrption(),
          _price(),
        ],
      ),
    );
  }

  Widget _buttonsAddToCart(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  '-',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 40),
                  primary: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  '0',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(40, 37),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  '+',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 40),
                  primary: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Agregar   ${product?.price ?? ''}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _price() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        '\$${product?.price ?? 0}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textDescrption() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 25, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _textTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _imageSlideShow(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              initialPage: 0,
              indicatorColor: Colors.amber,
              children: [
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image1 != null
                      ? NetworkImage(product!.image1!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider,
                ),
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image2 != null
                      ? NetworkImage(product!.image2!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider,
                ),
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image3 != null
                      ? NetworkImage(product!.image3!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider,
                )
              ])
        ],
      ),
    );
  }
}
