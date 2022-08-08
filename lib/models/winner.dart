class Winner {
  final String name;
  final String votes;

  Winner({
    required this.name,
    this.votes = '',
  });
  // "candidate_name": "aws nidhass",
  // "election_name": "testelection3",
  // "party_name": "fsf",
  // "candidate_id": "666665",
  // "votes": "0"

  static Winner fromJson(Map<String, dynamic> json) => Winner(
        name: json['candidate_name'],
        votes: json['votes'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'candidate_name': name,
        'votes': votes,
      };
}
