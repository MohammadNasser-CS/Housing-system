import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/admin_home_page_cubit/admin_home_page_cubit.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/models/admin_pages_models/owners_activation_request_model.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class ActivationRequestCard extends StatefulWidget {
  final OwnersActivationRequestModel roomRequestsModel;
  const ActivationRequestCard({super.key, required this.roomRequestsModel});

  @override
  State<ActivationRequestCard> createState() => _ActivationRequestCardState();
}

class _ActivationRequestCardState extends State<ActivationRequestCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> cancelRequest(String requestId) async {
    BlocProvider.of<MyRoomCubit>(context).cancelRequest(requestId);
  }

  void _showPhotoDialog(String photoUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  photoUrl,
                  fit: BoxFit.contain,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'إغلاق',
                  style: TextStyle(
                    color: AppColor.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AdminHomePageCubit>(context);
    return Container(
      height: size.height * 0.2,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsetsDirectional.all(8.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.grey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'إسم صاحب السكن: ',
                      value: widget.roomRequestsModel.name,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextWidget(
                        title: 'رقم الهاتف: ',
                        value: widget.roomRequestsModel.phoneNumber),
                  ],
                ),
              ),
              if (widget.roomRequestsModel.royaltyPhoto != null)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _showPhotoDialog(widget.roomRequestsModel.royaltyPhoto!);
                    },
                    child: Container(
                      height: size.height * 0.1,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Image.network(
                        widget.roomRequestsModel.royaltyPhoto!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColor.red,
                    ),
                  ),
                  onPressed: () async {
                    await cubit
                        .rejectHouseOwner(widget.roomRequestsModel.ownerId);
                  },
                  child: Text(
                    'رفض الطلب',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColor.green,
                    ),
                  ),
                  onPressed: () async {
                    await cubit
                        .acceptHouseOwner(widget.roomRequestsModel.ownerId);
                  },
                  child: Text(
                    'قبول الطلب',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
