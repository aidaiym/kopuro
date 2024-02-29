import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({
    super.key,
    required this.state,
    required this.onTap,
  });
  final ProfileState state;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: (state is ProfileImageUploadingState)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (state.uploadedImageUrl != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        state.uploadedImageUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
