import 'package:opporto_project/featuers/company_jobs/data/model/InterviewResponseModel.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class InterviewUseCase {
  final JopRepo jopRepo;

  InterviewUseCase({required this.jopRepo});

  Future<InterviewData> call({
    required String applicationId,
    required DateTime scheduledAt,
    required String interviewType,
    required String locationOrLink,
    required String token,
    String? notes,
  }) async {
    try {
      final res = await jopRepo.scheduleInterview(
        applicationId: applicationId,
        scheduledAt: scheduledAt,
        interviewType: interviewType,
        locationOrLink: locationOrLink,
        token: token,
        notes: notes,
      );

      return res;
    } catch (e) {
      rethrow;
    }
  }
}