import 'package:flutter/material.dart';
// import 'package:testverygood/features/groupsplit/add_split/view/split_screen.dart';
import 'package:testverygood/features/transaction/add_trans/view/transaction_screen.dart';
// import 'package:testverygood/features/transaction/scanbill/app.dart';
import 'package:testverygood/features/transaction/scanbill/widgets/btn_choose_AI.dart';
import 'package:testverygood/features/transaction/scanbill/widgets/btnchoose.dart';

class ImagePickerOptions extends StatefulWidget {
  const ImagePickerOptions({
    required this.onPickImage,
    required this.onPickCam,
    required this.onModelSelected,
    required this.selectedModel,
    super.key,
    this.showWarning = false,
  });
  final VoidCallback onPickImage;
  final VoidCallback onPickCam;
  final bool showWarning;
  final String selectedModel;
  final Function(String) onModelSelected;

  @override
  _ImagePickerOptionsState createState() => _ImagePickerOptionsState();
}

class _ImagePickerOptionsState extends State<ImagePickerOptions> {
  void _updateSelectedModel(String model) {
    setState(() {});
    widget.onModelSelected(model);
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TransactionMain()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.showWarning) ...[
                const Text(
                  'Please select or take photos again !',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your photo is not in the correct format',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              BtnChooseAi(
                iconPath: widget.selectedModel == 'GPT-4'
                    ? 'lib/assets/icon/OCR_icon/gpt_ai.svg'
                    : 'lib/assets/icon/OCR_icon/nest_ai.svg',
                onModelSelected: _updateSelectedModel,
                selectedModel: widget.selectedModel,
              ),
              CustomButton(
                text: 'Choose from gallery',
                iconPath: 'lib/assets/icon/OCR_icon/addpic.svg',
                onPressed: widget.onPickImage,
              ),
              CustomButton(
                text: 'Take a picture',
                iconPath: 'lib/assets/icon/OCR_icon/addcam.svg',
                onPressed: widget.onPickCam,
              ),
              CustomButton(
                text: 'Add Manually',
                iconPath: '',
                onPressed: () => navigateToTargetPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
