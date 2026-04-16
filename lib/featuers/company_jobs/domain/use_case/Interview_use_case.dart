import 'package:opporto_project/featuers/company_jobs/data/model/InterviewResponseModel.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class InterviewUseCase {
  JopRepo jopRepo;
  InterviewUseCase({required this.jopRepo});
  Future<InterviewResponseModel> call(
      {required String applicationId,
        required String scheduledAt,
        required String interviewType,
        required String locationOrLink,
        required String token,
        String? notes}) async {
    try {
      var res = await jopRepo.scheduleInterview(
          applicationId: applicationId,
          scheduledAt: scheduledAt,
          interviewType: interviewType,
          locationOrLink: locationOrLink,
          token: token,
          notes: notes);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}

