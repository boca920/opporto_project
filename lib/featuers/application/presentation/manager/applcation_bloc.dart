
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/application/domain/use_cases/app_ues_case.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_event.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final PostApplicationUseCase postApplicationUseCase;

  ApplicationBloc(this.postApplicationUseCase) : super(ApplicationState()) {
    on<SubmitApplicationEvent>((event, emit) async {
      print("🚀 Bloc Received Event: Submitting for Job ${event.jobId}");
      emit(state.copyWith(status: RequestStatus.loading));

      try {

        await postApplicationUseCase.execute(
          jobId: event.jobId,
          resume: event.resume,
          token: event.token,
          name: event.name,
          email: event.email,
          phone: event.phone,
          address: event.address,
          coverLetter: event.coverLetter,
        );


        emit(state.copyWith(
          status: RequestStatus.success,
          message: "تم تقديم طلبك بنجاح!",
        ));
      } catch (e) {

        emit(state.copyWith(
          status: RequestStatus.error,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}