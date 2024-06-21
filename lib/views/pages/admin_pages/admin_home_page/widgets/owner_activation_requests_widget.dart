import 'package:flutter/material.dart';
import 'package:housing_project/models/admin_pages_models/owners_activation_request_model.dart';
import 'package:housing_project/views/pages/admin_pages/admin_home_page/widgets/activationr_request_card.dart';

class OwnerActivationRoomRequestsWidget extends StatefulWidget {
  final List<OwnersActivationRequestModel> requestsModel;
  const OwnerActivationRoomRequestsWidget(
      {super.key, required this.requestsModel});

  @override
  State<OwnerActivationRoomRequestsWidget> createState() =>
      _OwnerActivationRoomRequestsWidgetState();
}

class _OwnerActivationRoomRequestsWidgetState
    extends State<OwnerActivationRoomRequestsWidget> {
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
                  child: ActivationRequestCard(roomRequestsModel: roomRequest),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
