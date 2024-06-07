import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/my_room_page/widgets/room_item.dart';
import 'package:housing_project/views/pages/my_room_page/widgets/room_requests_widget.dart';
import 'package:housing_project/views/widgets/owner_no_requests_wiget.dart';

class MyRoomPage extends StatelessWidget {
  final UserModel user;
  const MyRoomPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<MyRoomCubit>(context);
    return BlocBuilder<MyRoomCubit, MyRoomState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is MyRoomLoading ||
          current is MyRoomLoaded ||
          current is RoomRequestsLoaded ||
          current is NoRequestAndNoRoom ||
          current is MyRoomError,
      builder: (context, state) {
        if (state is MyRoomLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        } else if (state is MyRoomLoaded) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: size.width * 0.01,
                vertical: size.height * 0.022,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoomItem(
                      room: state.room,
                      house: state.house,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is RoomRequestsLoaded) {
          return const RoomRequestsWidget();
        } else if (state is NoRequestAndNoRoom) {
          return const NoItemsWidget(
              title: 'لم تقم بحجز أو طلب حجز لأي غرفة');
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
