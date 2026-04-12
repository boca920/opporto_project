import 'package:bloc/bloc.dart';

import 'package:opporto_project/featuers/company_jobs/domain/use_case/application_job_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/get_Job_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/jop_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/update_profile_ues_case.dart';
import 'package:opporto_project/featuers/company_jobs/domain/use_case/user_company_use_case.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JopUseCase jopUseCase;
  final UserCompanyUseCase userCompanyUseCase;
  final UpdateProfileUesCase updateProfileUseCase;
  final GetJobUseCase getJobUseCase;
  final ApplicationJobUseCase getApplicationsUseCase;




  JobBloc({required this.jopUseCase,
    required this.userCompanyUseCase,
    required this.updateProfileUseCase,
    required this.getJobUseCase,
    required this.getApplicationsUseCase,
  }) : super(JobState()) {
    on<AddJobEvent>(onAddJobEvent);
    on<GetMyJobsEvent>(onGetMyJobsEvent);
    on<GetUserDataEvent>(onGetUserDataEvent);
    on<UpdateProfileEvent>(onUpdateProfileEvent);
    on<GetApplicationsEvent>(onGetApplicationsEvent);

  }

  void onAddJobEvent(AddJobEvent event, Emitter<JobState> emit){
    emit(state.copyWith(status: RequestStatus.loading));

    try{
      var result = jopUseCase.call(event.jobData, event.userToken);
      emit(state.copyWith(status: RequestStatus.success));
    }catch(e){
      emit(state.copyWith(status: RequestStatus.error));
    }


  }
  Future<void> onGetMyJobsEvent(GetMyJobsEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      var result = await getJobUseCase.call(event.token);
      emit(state.copyWith(
        status: RequestStatus.success,
        jobs: result,
      ));

    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }
  }
  Future<void> onGetUserDataEvent(GetUserDataEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      var result = await userCompanyUseCase.call(event.userToken);

      final mergedUser = state.userModel?.copyWith(
        name: result.name,
        phone: result.phone,
      );

      emit(state.copyWith(
        status: RequestStatus.success,
        userModel: mergedUser ?? result,
      ));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }
  }
  Future<void> onUpdateProfileEvent(UpdateProfileEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      await updateProfileUseCase.call(
        token: event.token,
        name: event.name,
        phone: event.phone,
        about: event.about,
        industry: event.industry,
      );

      emit(state.copyWith(
        status: RequestStatus.success,
        userModel: state.userModel?.copyWith(
          name: event.name,
          phone: event.phone,
          about: event.about,
          industry: event.industry,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RequestStatus.error,
        message: e.toString(),
      ));
    }
  }
  Future<void> onGetApplicationsEvent(GetApplicationsEvent event, Emitter<JobState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      var result = await getApplicationsUseCase.call(event.token);

      emit(state.copyWith(
        status: RequestStatus.success,
        applications: result,
      ));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error));
    }
  }

}