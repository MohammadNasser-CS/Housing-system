import 'package:flutter/material.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:housing_project/views/pages/student_pages/my_room_page/widgets/room_request_widget_components/room_request_card.dart';

class RoomRequestsWidget extends StatefulWidget {
  final List<RoomRequestsModel> requestsModel;
  const RoomRequestsWidget({super.key, required this.requestsModel});

  @override
  State<RoomRequestsWidget> createState() => _RoomRequestsWidgetState();
}

class _RoomRequestsWidgetState extends State<RoomRequestsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
              itemCount: widget.requestsModel.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final roomRequest = widget.requestsModel[index];
                return Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 8.0),
                  child: RoomRequestCard(roomRequestsModel: roomRequest),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
