class Candidate {
  final String candidateId;
  final String name;
  final String partyName;
  final String electionName;

  Candidate({
    required this.candidateId,
    required this.name,
    this.partyName = '',
    this.electionName = '',
  });
  // "candidate_name": "aws nidhass",
  // "election_name": "testelection3",
  // "party_name": "fsf",
  // "candidate_id": "666665",
  // "votes": "0"

  static Candidate fromJson(Map<String, dynamic> json) => Candidate(
        candidateId: json['candidate_id'],
        name: json['candidate_name'],
        partyName: json['party_name'] ?? '',
        electionName: json['election_name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'candidate_id': candidateId,
        'candidate_name': name,
        'party_name': partyName,
        'election_name': electionName,
      };
}
