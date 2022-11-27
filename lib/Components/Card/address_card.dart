import 'package:ecommerce/Component2/Buttons/SolidButton.dart';
import 'package:ecommerce/Component2/Input/InputField.dart';
import 'package:ecommerce/Models/AddressModel.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/Space.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatefulWidget {
  AddressModel? address;
  void Function() onEditDone;
  bool select;
  String? addressId;
  Function(dynamic value)? onSelect;
  bool showEdit;
  bool showDelete;
  AddressCard({
    super.key,
    this.address,
    required this.onEditDone,
    this.select = false,
    this.addressId = "",
    this.onSelect,
    this.showEdit = true,
    this.showDelete = true,
  });

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController number = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  updateAddressData() {
    AddressModel userData = AddressModel(
      username: fullname.text,
      address: address.text,
      contact: number.text,
      pincode: pincode.text,
      addressUid: widget.address!.addressUid,
    );
    updateAddress(userData);
    Navigator.pop(context);
    widget.onEditDone();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (widget.select)
              Expanded(
                child: Radio(
                  value: widget.address!.addressUid!,
                  groupValue: widget.addressId,
                  onChanged: (value) {
                    widget.onSelect!(value);
                  },
                  activeColor: secondary,
                ),
              ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.address!.username!,
                      style: const TextStyle(
                        color: secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const VerticalSpace(space: 8),
                    Text(
                      widget.address!.address!,
                      style: TextStyle(
                        color: black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const VerticalSpace(space: 4),
                    Text(
                      widget.address!.pincode!,
                      style: TextStyle(
                        color: black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const VerticalSpace(space: 4),
                    Text(
                      widget.address!.contact!,
                      style: TextStyle(
                        color: black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  if (widget.showEdit)
                    IconButton(
                      onPressed: () {
                        fullname.text = widget.address!.username!;
                        address.text = widget.address!.address!;
                        pincode.text = widget.address!.pincode!;
                        number.text = widget.address!.contact!;
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return Container(
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.5,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    8,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const VerticalSpace(
                                        space: 4,
                                      ),
                                      const Text(
                                        'Update your address',
                                        style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const VerticalSpace(
                                        space: 8,
                                      ),
                                      InputField(
                                        label: "Full Name",
                                        controller: fullname,
                                      ),
                                      InputField(
                                        label: "Address",
                                        controller: address,
                                      ),
                                      InputField(
                                        label: "Pincode",
                                        controller: pincode,
                                        type: TextInputType.number,
                                      ),
                                      InputField(
                                        label: "Contact Number",
                                        type: TextInputType.phone,
                                        controller: number,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: SolidButton(
                                          onPressed: updateAddressData,
                                          color: primary,
                                          label: "Update",
                                        ),
                                      ),
                                      VerticalSpace(
                                        space: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: primary,
                      ),
                    ),
                  if (widget.showDelete)
                    IconButton(
                      onPressed: () async {
                        AddressModel add = AddressModel(
                            addressUid: widget.address!.addressUid);
                        await deleteAddress(add);
                        widget.onEditDone();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: danger,
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
