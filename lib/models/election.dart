class Election {
  final int electionId;
  final String name;
  final int noOfVoters;
  final int noOfCandidates;
  final bool ongoing;

  Election({
    required this.electionId,
    required this.name,
    required this.noOfVoters,
    required this.noOfCandidates,
    required this.ongoing,
  });

  static Election fromJson(Map<String, dynamic> json) => Election(
        electionId: json['election_id'],
        name: json['election_name'],
        ongoing: json['on_going'],
        noOfVoters: json['no_of_voters'] ?? '',
        noOfCandidates: json['no_of_candidates'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'election_id': electionId,
        ' on_going': ongoing,
        'election_name': name,
        'no_of_voters': noOfVoters,
        'no_of_candidates': noOfCandidates,
      };
}
