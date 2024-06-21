import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/views/widgets/no_items_wiget.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/request_tap_view_widgets/owner_room_request_card.dart';

class RequestsTabView extends StatelessWidget {
  const RequestsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHomePageCubit>(context);
    return BlocConsumer<OwnerHomePageCubit, OwnerHomePageState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is RequestDeleted || current is MyRoomError,
      listener: (context, state) {
        if (state is RequestDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is MyRoomError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      buildWhen: (previous, current) {
        return current is! HouseDetailsLoaded;
      },
      builder: (context, state) {
        if (state is RoomRequestsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is MyRoomError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is RoomRequestsLoaded &&
            state.roomRequests.isNotEmpty) {
          return RefreshIndicator(
              onRefresh: () async {
                return await cubit.getRequestsData();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 4.0),
                      itemCount: state.roomRequests.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final roomRequest = state.roomRequests[index];
                        return Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 8.0),
                          child: OwnerRoomRequestCard(
                              roomRequestsModel: roomRequest),
                        );
                      },
                    ),
                  ],
                ),
              ));
        } else {
          return const NoItemsWidget(
            title: 'لا يوجد أي طلبات',
            icon: Icons.block,
          );
        }
      },
    );
  }
}
