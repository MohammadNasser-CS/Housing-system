import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/admin_home_page_cubit/admin_home_page_cubit.dart';
import 'package:housing_project/views/pages/admin_pages/admin_home_page/widgets/owner_activation_requests_widget.dart';
import 'package:housing_project/views/widgets/no_items_wiget.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AdminHomePageCubit>(context);
    return BlocConsumer<AdminHomePageCubit, AdminHomePageState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is OwenrActicationRequestDeleted || current is AdminHomePageError,
      listener: (context, state) {
        if (state is OwenrActicationRequestDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is AdminHomePageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is AdminHomePageLoading ||
          current is AdminHomePageLoaded ||
          current is NoOwenrActicationRequestAndNoRoom,
      builder: (context, state) {
        if (state is AdminHomePageLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        }  else if (state is AdminHomePageLoaded) {
          return OwnerActivationRoomRequestsWidget(requestsModel: state.roomRequests);
        } else if (state is NoOwenrActicationRequestAndNoRoom) {
          return const NoItemsWidget(
            title: 'لم تقم بحجز أو طلب حجز لأي غرفة',
            icon: Icons.block,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
