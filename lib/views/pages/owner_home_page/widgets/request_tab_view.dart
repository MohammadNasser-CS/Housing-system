import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/widgets/owner_no_requests_wiget.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/request_tap_view_widgets/owner_room_request_card.dart';

class RequestsTabView extends StatelessWidget {
  final UserModel user;
  const RequestsTabView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHomePageCubit>(context);
    return BlocBuilder<OwnerHomePageCubit, OwnerHomePageState>(
      bloc: cubit,
      buildWhen: (previous, current) {
        return current is! HouseDetailsLoaded;
      },
      builder: (context, state) {
        if (state is OwnerHomePageLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is OwnerHomePageError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is OwnerHomeRequestsLoaded &&
            state.request.isNotEmpty) {
          return RefreshIndicator(
              onRefresh: () async {
                return await cubit.getHomeData(user);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 4.0),
                      itemCount: state.request.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final roomRequest = state.request[index];
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
          );
        }
      },
    );
  }
}
