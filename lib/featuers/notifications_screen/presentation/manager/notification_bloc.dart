import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/use_case/all_read_use_case.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/use_case/get_notifications_useCase.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/use_case/notification_read_use_case.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_event.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetMyNotificationsUseCase getNotificationsUseCase;
  final NotificationReadUseCase readUseCase;
  final AllReadUseCase allReadUseCase;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.readUseCase,
    required this.allReadUseCase,
  }) : super(NotificationState()) {


    on<GetNotificationsEvent>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.loading));
      try {
        final result = await getNotificationsUseCase.call(
          event.token,
        );
        emit(state.copyWith(
          status: RequestStatus.success,
          notifications: result.notifications ?? [],
          unreadCount: result.unreadCount ?? 0,
        ));
      } catch (e) {
        emit(state.copyWith(status: RequestStatus.error, errorMessage: e.toString()));
      }
    });


    on<ReadEvent>((event, emit) async {
      try {
        await readUseCase.call(event.id,event.token);


        final updatedList = state.notifications.map((n) {
          return n.id == event.id ? n.copyWith(isRead: true) : n;
        }).toList();

        emit(state.copyWith(
          notifications: updatedList,
          unreadCount: (state.unreadCount > 0) ? state.unreadCount - 1 : 0,
        ));
      } catch (e) {
        emit(state.copyWith(status: RequestStatus.error, errorMessage: e.toString()));
      }
    });


    on<AllReadEvent>((event, emit) async {
      try {
        await allReadUseCase.call(
          event.token,
        );
        final updatedList = state.notifications.map((n) => n.copyWith(isRead: true)).toList();
        emit(state.copyWith(notifications: updatedList, unreadCount: 0));
      } catch (e) {
        emit(state.copyWith(status: RequestStatus.error, errorMessage: e.toString()));
      }
    });
  }
}