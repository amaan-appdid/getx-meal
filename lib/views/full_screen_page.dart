import 'package:flutter/material.dart';

class FullScreenPage extends StatefulWidget {
  const FullScreenPage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
