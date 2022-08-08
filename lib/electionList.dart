import 'package:app_vote/api/core_api.dart';
import 'package:app_vote/candidates_page.dart';
import 'package:app_vote/models/election.dart';
import 'package:app_vote/models/user.dart';
import 'package:flutter/material.dart';

class ElectionList extends StatelessWidget {
  final User voter;
  const ElectionList({Key? key, required this.voter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Elections",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<List<Election>>(
        future: CoreAPI.getElections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Text('Something went wrong please try again later');
          }
          final elections = snapshot.data!;
          return ListView.separated(
            separatorBuilder: ((context, index) => Divider()),
            itemBuilder: ((context, index) {
              final election = elections[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CandidatesPage(
                          election: election,
                          voter: voter,
                        ),
                      ),
                    );
                  },
                  title: Text(election.name),
                  subtitle: Text('No of candidates: ' +
                      election.noOfCandidates.toString()),
                  // leading: Image.network(
                  //     'https://source.unsplash.com/random?sig=index'),
                ),
              );
            }),
            itemCount: elections.length,
          );
        },
      ),
    );
  }
}
