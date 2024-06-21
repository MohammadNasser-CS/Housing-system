import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/views/pages/student_pages/my_room_page/widgets/room_item.dart';
import 'package:housing_project/views/pages/student_pages/my_room_page/widgets/room_requests_widget.dart';
import 'package:housing_project/views/pages/shared_pages/widgets/no_items_wiget.dart';

class MyRoomPage extends StatelessWidget {
  const MyRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<MyRoomCubit>(context);
    return BlocConsumer<MyRoomCubit, MyRoomState>(
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
      buildWhen: (previous, current) =>
          current is MyRoomLoading ||
          current is MyRoomLoaded ||
          current is RoomRequestsLoaded ||
          current is NoRequestAndNoRoom||current is MyRoomError,
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
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is RoomRequestsLoaded) {
          return RoomRequestsWidget(requestsModel: state.roomRequests);
        } else if (state is NoRequestAndNoRoom) {
          return const NoItemsWidget(
            title: 'لم تقم بحجز أو طلب حجز لأي غرفة',
            icon: Icons.block,
          );
        } else if(state is MyRoomError){
          Center(child:Text(state.message));
        }{
          return const SizedBox.shrink();
        }
      },
    );
  }
}
