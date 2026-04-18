import 'dart:io';

abstract class ApplicationEvent {}

class SubmitApplicationEvent extends ApplicationEvent {
  final String jobId;
  final File resume;
  final String token;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String coverLetter;

  SubmitApplicationEvent({
    required this.jobId,
    required this.resume,
    required this.token,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.coverLetter,
  });
}