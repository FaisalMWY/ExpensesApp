import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingTotal);
  @override
  Widget build(BuildContext context) {
    // LayoutBuilder is used to have a responsive view, no matter what the
    // screen size is, the view/page will adapt and resize
    return LayoutBuilder(
      // context is needed for the app to have an idea about the widget tree
      // constrants are needed to have an idea about the constraints of
      // the device whether heigt, width, dimensions and much more useful tools.
      builder: (context, constraints) => Column(
        children: [
          // there are many ways to use height in flutter. some people use
          // a container, some use padding and others use other widgets.
          // the reason I chose SizedBox was to try to be as specific
          // as possilbe as sized box is known to be used as a splitter between
          // widgets.
          SizedBox(
            // constraints.maxHeight findns the max height of the device used.
            // we multiplied it with .15 because we wanted the text to use
            // 15% of the parent widget's height.
            height: constraints.maxHeight * .15,
            // fitted box was used to snug the text inside the sized box. and
            // assures that the size of the widget never exceeds the size given
            // in this case its 15%, So whenever the widget wants to exceed
            // the limits, it gits smaller.
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          // this sized box acts as a splitter between spendingAmount's text
          // and the bar beneath it the splitter in this case takes 5% space
          // of the parent's widget
          SizedBox(height: constraints.maxHeight * .05),
          // this Container holds the bars that show the average
          // spending of the user
          Container(
            // we gave this container 60% of the parent's height.
            height: constraints.maxHeight * .6,
            width: 10,
            // a stack was used to insert widgets in top of each other.
            // the way stacks work is the first widget the furthest down and the
            // second one is above the first one spoilers alert, its just like
            // a normal stack - .-
            child: Stack(
              children: [
                // this container is the bar that shows average spending per day
                Container(
                  // decoration is used to, well... to decorate the container :|
                  decoration: BoxDecoration(
                    // border is used to create and decorat the border of
                    // the parent widget, as we can see here we have colored
                    // the border in grey. but we havent added a width to it
                    // whats the point? well when adding a border it is set to
                    // width one by standard, so if width 1 is what we need
                    // we can either leave it as is without adding the width or
                    // the better practice is to add width: 1 so later on it's
                    // easier to spot specially when working with team mates.
                    border: Border.all(color: Colors.grey),
                    // this is another way of^ coloring widgets rather than using
                    // hash codes or straight^ typing the color
                    // like the line above   ^
                    color: Color.fromRGBO(220, 220, 220, 1),
                    // borderRadius adds curves to the edges of the parent widget
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // FractionallySizedBox is a useful tool that allows us to set
                // it's child as a precentage of the parent's size
                FractionallySizedBox(
                  // as we see here spendingTotal is the average user spending
                  // so if the user's average spending is 50% of the usual.
                  // then 50% of the bar will be filled
                  heightFactor: spendingTotal,
                  // this child's height will^ change depending on the spending
                  // total in the line above ^
                  child: Container(
                    // decoration for decoration the container
                    decoration: BoxDecoration(
                        // color for coloring the container
                        color: Theme.of(context).primaryColor,
                        // border radius for setting how curvy are the edges of
                        // the container.
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          // SizedBox that acts as a splitter with a size of 15% of the screen's
          // height
          SizedBox(height: constraints.maxHeight * .05),
          // SizedBox that contains text that is given 15% of the screen's
          // height
          SizedBox(
              height: constraints.maxHeight * .15,
              // fitted box was used to insure that the text snugs into place.
              child: FittedBox(child: Text(label)))
        ],
      ),
    );
  }
}
