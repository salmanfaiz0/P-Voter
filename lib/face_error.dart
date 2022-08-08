import 'package:app_vote/camera_page.dart';
import 'package:app_vote/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/candidate.dart';

class FaceError extends StatefulWidget {
  final Candidate candidate;
  final User voter;
  const FaceError({required this.candidate, required this.voter});

  @override
  State<FaceError> createState() => _FaceErrorState();
}

class _FaceErrorState extends State<FaceError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraPage(
                        candidate: widget.candidate,
                        voter: widget.voter,
                      )),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
