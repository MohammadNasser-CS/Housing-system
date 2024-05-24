import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/user_home_page_cubit/user_home_cubit.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
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
    final cubit = BlocProvider.of<HomeCubit>(context);
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
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
            decoration: const InputDecoration(
              hintText: 'إسم صاحب السكن...',
              prefixIcon: Icon(Icons.search_outlined),
              prefixIconColor: AppColor.grey,
              fillColor: AppColor.white,
              filled: true,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.03),
        InkWell(
          onTap: () {},
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsetsDirectional.all(size.width * 0.03),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              FontAwesomeIcons.sliders,
              color: AppColor.white,
              size: size.width * 0.05,
            ),
          ),
        ),
      ],
    );
  }
}
