import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'package:bmi_calculator/reuseable_card.dart';
import 'constants.dart';
import 'package:bmi_calculator/results_page.dart';
import 'bottom_button.dart';
import 'package:bmi_calculator/round_button.dart';
import 'calcalutor_brain.dart';

enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
    Gender selectedGender;
    int height=180;
    int weight=60;
    int age=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Row(
            children: [
              Expanded(child:Reuseablecard(
                 colour:selectedGender==Gender.male?kActiveCardcolor:kInactiveCardcolor,
                 cardChild:IconContent(FontAwesomeIcons.mars,'MALE'),
                onPress:(){
                   setState((){
                      selectedGender=Gender.male;
                   });
                }
              ),),
              Expanded(child: Reuseablecard(
                onPress: (){
                  setState((){
                    selectedGender=Gender.female;
                  });
                },
                  colour:selectedGender==Gender.female?kActiveCardcolor:kInactiveCardcolor,
                  cardChild:IconContent(FontAwesomeIcons.venus,'FEMALE')
              ),),
            ],
           )
          ),
          Expanded(child:Reuseablecard(
            colour: kActiveCardcolor,
            cardChild:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEIGHT',
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$height',
                      style:kNumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kLabelTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xFF8D8E98),
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                  ),
                  child: Slider(
                      value: height.toDouble(),
                      min:120.0,
                      max:220.0,
                      onChanged:(double newValue){
                           setState((){
                             height=newValue.toInt();
                           });
                      }
                  ),
                ),
              ],
            ) ,
          ),),
          Expanded(child: Row(
            children: [
              Expanded(child: Reuseablecard(
                colour: kActiveCardcolor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'WEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      '$weight',
                      style: kNumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: (){
                            setState((){
                              weight--;
                            });
                          },
                        ),
                        SizedBox(width: 10,),
                        RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: (){
                            setState((){
                              weight++;
                            });
                          }
                        ),
                      ],
                    )
                  ],
                ),
              ),),
              Expanded(child: Reuseablecard(
                colour: kActiveCardcolor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AGE',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      '$age',
                      style: kNumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: (){
                            setState((){
                              age--;
                            });
                          },
                        ),
                        SizedBox(width: 10,),
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: (){
                              setState((){
                                age++;
                              });
                            }
                        ),
                      ],
                    )
                  ],
                ),
              ),),
            ],
           )
          ),
          BottomButton(buttonTitle: 'CALCULATE',onTap:(){
            CalculatorBrain calc=CalculatorBrain(height:height ,weight: weight);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>ResultsPage(
                   bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                )
                )
            );
          },),
        ],
      )
    );
  }
}



