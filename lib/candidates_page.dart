import 'package:app_vote/api/core_api.dart';
import 'package:app_vote/models/candidate.dart';
import 'package:app_vote/models/election.dart';
import 'package:app_vote/result_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:app_vote/camera_page.dart';

import 'models/user.dart';

class CandidatesPage extends StatelessWidget {
  final Election election;
  final User voter;
  const CandidatesPage({Key? key, required this.election, required this.voter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidates'),
        actions: [
          TextButton(
            onPressed: election.ongoing
                ? null
                : () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResultPage(election: election)));
                  },
            child: Text('View Result'),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Candidate>>(
          future: CoreAPI.getCandidates(election.name),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data);
            if (snapshot.hasError || snapshot.data == null)
              return Text('Something went wrong please try again later');
            final candidates = snapshot.data!;
            return ListView.separated(
              separatorBuilder: ((context, index) => Divider()),
              itemBuilder: ((context, index) {
                final candidate = candidates[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    onTap: () async {
                      await availableCameras().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(
                              voter: voter,
                              cameras: value,
                              candidate: candidate,
                            ),
                          ),
                        ),
                      );
                    },
                    leading: Image.network(
                        'https://bvoter.s3.ap-south-1.amazonaws.com/' +
                            candidate.candidateId +
                            '.jpg'),
                    title: Text(candidate.name),
                    subtitle: Text(
                      'Party Name: ' + candidate.partyName,
                    ),
                    // leading: Image.network(
                    //     'https://source.unsplash.com/random?sig=index'),
                  ),
                );
              }),
              itemCount: candidates.length,
            );
          },
        ),
      ),
    );
  }
}
