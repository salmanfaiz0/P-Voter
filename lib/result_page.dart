import 'dart:math';

import 'package:app_vote/models/election.dart';
import 'package:flutter/material.dart';

import 'api/core_api.dart';
import 'models/winner.dart';

class ResultPage extends StatelessWidget {
  final Election election;
  const ResultPage({Key? key, required this.election}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Results'),
      ),
      body: FutureBuilder<Winner>(
        future: CoreAPI.getResult(election),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print(snapshot.data);
          if (snapshot.hasError || snapshot.data == null) {
            return const Text('Something went wrong please try again later');
          }
          print(snapshot.data);
          final winner = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('The Winner IS....', style: TextStyle(fontSize: 22)),
                SizedBox(height: 12),
                Text(
                  winner.name,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text('With ' + winner.votes + ' Votes',
                    style: TextStyle(fontSize: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}
