import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalRoute extends StatelessWidget {
  const FinalRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          title: const Text('Vote Casting'),
        ),
        body: const Center(
          child: Text('Vote Has Been Casted'),
        ),
      );
    
  }
}