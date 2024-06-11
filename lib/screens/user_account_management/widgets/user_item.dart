import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/theme_color.dart';
import '../../../podo/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  final void Function(User user)? onDelete;
  const UserItem({Key? key, required this.user, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: ThemeColor.level4,
                child: Icon(Icons.person),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    Text(user.name),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              InkWell(
                onTap: () => onDelete?.call(user),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Delete",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
