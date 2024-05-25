import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';

class OwnerHomePageSearchSectionSearchSection extends StatefulWidget {
  const OwnerHomePageSearchSectionSearchSection({super.key});

  @override
  State<OwnerHomePageSearchSectionSearchSection> createState() =>
      _OwnerHomePageSearchSectionSearchSectionState();
}

class _OwnerHomePageSearchSectionSearchSectionState
    extends State<OwnerHomePageSearchSectionSearchSection> {
  // late final GlobalKey<FormState> _formKey;
  late final TextEditingController _searchController;

  String? onwerName, password;
  late FocusNode _searchFocusNode;
  bool visibility = false;
  @override
  void initState() {
    // _formKey = GlobalKey<FormState>();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHomePageCubit>(context);
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: TextFormField(
            textAlign: TextAlign.right,
            controller: _searchController,
            focusNode: _searchFocusNode,
            // onEditingComplete: () {
            //   _searchFocusNode.unfocus();
            //   FocusScope.of(context)
            //       .requestFocus(_passwordFocusNode);
            // },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              // debugPrint(value);
              cubit.searchFilled(value);
              onwerName = value;
            },
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return "قم بإدخال إسم المستخدم الخاص بك.";
            //   } else if (!value.contains('@')) {
            //     return "إسم المستخدم غير مناسب";
            //   } else {
            //     return null;
            //   }
            // },
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.all(size.width * 0.03),
              hintText: 'إسم صاحب السكن...',
              prefixIcon: const Icon(Icons.search_outlined),
              prefixIconColor: AppColor.grey,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {},
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsetsDirectional.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColor.orange8,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                FontAwesomeIcons.sliders,
                color: AppColor.white,
                size: size.width * 0.05,
              ),
            ),
          ),
        ),
      ],
    );
  }
}