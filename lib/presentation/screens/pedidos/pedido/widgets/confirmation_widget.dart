import 'package:flutter/material.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
          Text(
            'Pedido realizado correctamente',
            style: TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Continuar', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
