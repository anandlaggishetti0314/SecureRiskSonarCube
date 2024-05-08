import 'package:flutter/material.dart';
import 'CorporateDetails.dart';
import 'CoverageDetails.dart';
import 'SendRFQ.dart';

class HorizontalStepperExampleApp1 extends StatefulWidget {
  const HorizontalStepperExampleApp1({Key? key}) : super(key: key);

  @override
  _HorizontalStepperExampleAppState1 createState() =>
      _HorizontalStepperExampleAppState1();
}

class _HorizontalStepperExampleAppState1
    extends State<HorizontalStepperExampleApp1> {
  int currentStep = 0;
  CorporateDetails corporateDetails = CorporateDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepCancel: () {
            if (currentStep > 0) {
              setState(() {
                currentStep -= 1;
              });
            }
          },
          onStepContinue: () {
            bool isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          steps: getSteps(),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Corporate Details"),
        content: Container(
          color: Colors.white,
          child: CorporateDetails(),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Coverage Details"),
        content: Container(
          color: Colors.white,
          child: CoverageDetails(),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Expiring Details"),
        content: Container(
          color: Colors.white,
          child: Text("Expiring Details"),
        ),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text("Claim Details"),
        content: Container(
          color: Colors.white,
          child: Text("Claim Details"),
        ),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text("Policy Details"),
        content: Container(
          color: Colors.white,
          child: Text("policy terms"),
        ),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: const Text("Send RFQ"),
        content: Container(
          color: Colors.white,
          child: SendForm(),
        ),
      ),
    ];
  }
}
