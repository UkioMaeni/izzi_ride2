import 'package:flutter/material.dart';
import 'package:izzi_ride_2/pages/auth_page/components/auth_tile_wrapper.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network("https://i.pinimg.com/736x/25/52/81/25528187d8a32d1c998a63e3b301de86.jpg",fit: BoxFit.cover,)
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AuthTileWrapper()
          )
        ],
      ),
    );
  }
}