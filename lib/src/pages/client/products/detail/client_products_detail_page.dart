import 'package:flutter/material.dart';

class ClientProductsDetailPage extends StatelessWidget {
  const ClientProductsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del producto'),
      ),
      body: Center(
        child: Text('Detalle del producto'),
      ),
    );
  }
}
