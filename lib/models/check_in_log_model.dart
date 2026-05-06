class CheckInLogModel {
  const CheckInLogModel({
    required this.participantId,
    required this.participantName,
    required this.time,
  });

  final String participantId;
  final String participantName;
  final DateTime time;
}