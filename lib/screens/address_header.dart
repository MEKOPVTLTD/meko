import 'package:flutter/material.dart';

class AddressHeader extends StatefulWidget {
  const AddressHeader(
      {super.key,
      required this.isLoadingAddress,
      required this.isSavingAddress,
      required this.addAddress});

  final bool isLoadingAddress;
  final bool isSavingAddress;
  final Function addAddress;

  @override
  State<AddressHeader> createState() => _AddressHeaderState();
}

class _AddressHeaderState extends State<AddressHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.08, 0, 0),
          child: ListTile(
            title: const Text(
              "Select Address",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            trailing: SizedBox(
              width: 40,
              child: Row(
                children: [
                  Expanded(
                      child: IconButton(
                    onPressed: widget.isLoadingAddress || widget.isSavingAddress
                        ? null
                        : () {
                            widget.addAddress();
                          },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
