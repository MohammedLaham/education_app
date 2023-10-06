import 'package:equatable/equatable.dart';

class UserLocal extends Equatable {
  const UserLocal({
    required this.uid,
    required this.email,
    required this.profilePic,
    required this.bio,
    required this.points,
    required this.fullName,
    required this.groupId,
    required this.enrolledCourseIds,
    required this.follwing,
    required this.follwers,
  });

  UserLocal.empty() : this(
    uid: '',
    email: '',
    points: 0,
    fullName: '',
    profilePic: '',
    bio: '',
    groupId: const [],
    enrolledCourseIds: const [],
    follwers: const [],
    follwing: const []
  );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> follwing;
  final List<String> follwers;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'UserLocal{uid: $uid, email: $email, bio: $bio, points: $points, fullName: $fullName}';
  }
}
