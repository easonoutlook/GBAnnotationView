-----------

**As of this commit this is still a work in progress and not ready for a beta (let alone production), I will update the releases when a beta is ready to try out.**

-----------

GBAnnotationView
================

iOS Custom Map Annotations.
A custom MapView, AnnotationView, and MapCalloutView to use so that we can easily customize the map to our specific needs.

The main purpose was to add the ability to add arbitrary views to the Map Callouts when an Annotation was tapped.  This endeavour was heavily inspired by [nfarina](https://github.com/nfarina)'s  [SMCalloutView](https://github.com/nfarina/calloutview), which is brilliant by the way. My goal was less pixel perfect emulation of the OS defaults and more customization and adaptability.

There are 3 main Classes here:

    GBAnnotationView
    GBCustomCallout
    GBMapView
    
These classes serve as a base to be sublclassed into something more useful to you.

The main difference from the UI* class equivalents is that the maintain a weak reference to each other so that the callout view can affect the map and the Annotation view (or delegate) makes all the decisions about customization and display.

### Demo
Checkout the demo project to see an example of how to use these classes.


### Tests
To run the tests you must have [cocoapods](http://cocoapods.org/) installed. Just clone the repository, run pods install in the demo directory, and open the generated workspace instead of the project to be able to run the [Kiwi](https://github.com/allending/Kiwi/wiki) tests.
