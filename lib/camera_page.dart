import 'package:app_vote/api/core_api.dart';
import 'package:app_vote/face_error.dart';
import 'package:app_vote/final_route.dart';
import 'package:app_vote/models/candidate.dart';
import 'package:app_vote/models/user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final Candidate candidate;
  final User voter;
  const CameraPage(
      {this.cameras, Key? key, required this.candidate, required this.voter})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    // controller = CameraController(
    //   widget.cameras![0],
    //   ResolutionPreset.medium,
    //   imageFormatGroup: ImageFormatGroup.jpeg,
    // );
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
    //   return const SizedBox(
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Recognition'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 300, height: 200),
          child: ElevatedButton(
            child: const Text('Capture Face'),
            onPressed: () async {
              XFile? pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera, maxHeight: 1920, maxWidth: 1080);
              if (pickedFile != null) {
                if (await CoreAPI.sendImage(
                        widget.voter, pickedFile, widget.candidate) !=
                    true) {
                  (Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FinalRoute())));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FaceError(
                                candidate: widget.candidate,
                                voter: widget.voter,
                              )));
                }
              }
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
