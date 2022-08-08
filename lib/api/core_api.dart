import 'dart:convert';
import 'dart:io';

import 'package:app_vote/models/election.dart';
import 'package:app_vote/models/user.dart';
import 'package:app_vote/models/winner.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../models/candidate.dart';

class CoreAPI {
  static Future<List<Election>> getElections() async {
    final url = 'http://43.204.209.119:4000/electiontableview';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    final elections = json.decode(response.body);
    print(elections);
    print(elections.runtimeType);
    final elecs = (elections as List).map((e) => Election.fromJson(e)).toList();
    print(elecs);
    return elecs;
  }

  static Future<Winner> getResult(Election election) async {
    final url = Uri.parse('http://43.204.209.119:4000/winner');

    final response = await http.post(url,
        body: {'election': election.name},
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});
    print(response.body);
    final resp = json.decode(response.body);
    final winner = Winner.fromJson(resp[0]);
    return winner;
  }

  static Future<User> getVoter(String mobile) async {
    print("Runnning getVoter");
    final url = 'http://43.204.209.119:4000/getvoter?mobile=' + mobile;
    final response = await http.get(Uri.parse(url));
    print(response.body);
    final resp = json.decode(response.body);
    if (resp is Map && resp['error'] != null && resp['error'] == true) {
      throw Exception();
    }
    final user = User.fromJson(resp[0]);
    print("User fetched");
    return user;
  }

  static Future<List<Candidate>> getCandidates(String electionName) async {
    print("Runnning upoload");
    final url =
        'http://43.204.209.119:4000/candidateview?election=' + electionName;
    final response = await http.get(Uri.parse(url));
    print(response.body);
    final candi = json.decode(response.body);
    print(candi);

    final candidates =
        (candi as List).map((e) => Candidate.fromJson(e)).toList();
    return candidates;
  }

  static Future<bool> sendImage(
      User voter, XFile imageFile, Candidate candidate) async {
    var dio = Dio();
    final imageBytes = await imageFile.readAsBytes();
    final url = 'http://43.204.209.119:5000/facesvc/';
    final formData = FormData.fromMap({
      "candidateid": candidate.candidateId,
      "voterid": voter.userId,
      "imagefile": await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.name,
        contentType:
            new MediaType("image", "jpeg"), // Here we add the content type!
      ),
    });
    print(imageFile.path);
    final response = await dio.post(url,
        data: formData,
        options: Options(headers: {
          "Content-Type": 'multipart/form-data',
        }));
    print(response.data);
    print(response.runtimeType);
    // final resp = jsonDecode(response.data);
    // print(resp);
    // print(resp.runtimeType);
    final hasError = response.data['error'];
    print(hasError);
    return hasError;
  }
}
