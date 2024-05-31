import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/my_room_page/widgets/room_item.dart';

class MyRoomPage extends StatelessWidget {
  final UserModel user;
  const MyRoomPage({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<MyRoomCubit>(context);
    return BlocBuilder<MyRoomCubit, MyRoomState>(
      buildWhen: (previous, current) =>
          current is MyRoomLoading ||
          current is MyRoomLoaded ||
          current is MyRoomError,
      builder: (context, state) {
        if (state is MyRoomLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        } else if (state is MyRoomLoaded) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.022,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoomItem(
                        room: state.room, house: state.house, cubit: cubit),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsetsDirectional.all(
                                    size.height * 0.02),
                                backgroundColor: AppColor.orange8,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            child: const Text('إلغاء الحجز!'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
