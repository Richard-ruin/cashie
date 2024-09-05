import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cashie/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MembershipPage extends StatefulWidget {
  final String initialMembership;
  final Function(String) onMembershipChanged;

  MembershipPage(
      {required this.initialMembership, required this.onMembershipChanged});

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  late TextEditingController _membershipController;

  @override
  void initState() {
    super.initState();
    _membershipController =
        TextEditingController(text: widget.initialMembership);
  }

  @override
  void dispose() {
    _membershipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.membership),
      ),
      body: TextField(
        controller: _membershipController,
        onChanged: widget.onMembershipChanged,
      ),
    );
  }
}
