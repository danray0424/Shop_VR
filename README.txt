Shop VR

Market America coding sample
Dan Ray
dan@danray.net
919-824-1216


OVERVIEW

This app allows the user to place and interact with product images from shop.com in 3d space, using the iOS ARKit augmented reality API.

The first screen allows the user to query the Shop.com product search API with a search term of their choosing. It displays a list of results. The user can drill down to a product detail screen on any of the listed results.

From there the user can place the product image on a detected plane AR space (e.g. a table top). You may need to "look around" a little--the app will let you know when it's detected a flat surface it can work with. Tap to add a card featuring the product image. The cards will stand up on the surface, and you can move around and explore them. Moving and scaling cards is not presently supported.



INSTALLATION / BUILD

The AR functionality won't run on the emulator. It requires a physical iPhone 6s or later, with iOS 11. 

Per request I'm delivering an IPA file, though I've never used the iTunes-sync method of installing a develoment build (I have lots of experience with Crashlytics for deploying to testers, and some with TestFlight). As I don't personally sync my devices to iTunes, I'm not set up to test that method. 

I'd prefer you build directly to your phone from Xcode. Please connect your phone to a mac running Xcode.  Be sure you open the project from the workspace "Shop VR.xcworkspace" and NOT the "Shop VR.xcodeproj", so Xcode will pick up and build the "Pods" dependencies project.

Select your phone from the devices section of the Schemes drop down in the Xcode toolbar and hit the "play" button to build, install, and run. 

You may need to turn on automatic certificate management, which will make codesigning a one-click deal. If you haven't built from Xcode to your phone before, it will need to submit your phone's ID to the certificate portal, and may take several minutes "preparing debugger support" on your phone; you should let it do these things. 

I tested this out with a virgin clone out of Github, and it worked fine. But if you have trouble installing this way, let me know and I'll set the app up in Crashlytics and get it to you that way.


DEVELOPMENT COMMENTS

I elected to build this in native Objective-C as it's the platform I'm most familiar and fastest with. I used a standard iOS UINavigationView structure, drilling down from search control to results to details to the payoff on the AR screen. This navigational idiom is common and familiar to iOS users.

For UI simplicity, I limited the app to iPhones, and eliminated device rotation support. 

I used auto-layout to design the interfaces. The design ought to more or less survive any iPhone screen geometry. Auto-layout can be VERY complicated to learn, but once you understand how it thinks, it's the tool for the job.

On the product detail page, I started out with a raw text field for the product description, but quickly noticed that the product description is expressed in HTML. So I'm now rendering it in a WKWebView. I learned that how you control scaling in a WKWebView is by prepending a <header> tag with a viewport meta tag. Quite different from the UIWebView that it replaced!

In response to the "Style the application beyond base styling", I implemented a custom app icon and a custom launch screen.  


TODOS / KNOWN ISSUES

There are many iteration targets for this app, to make it more featureful, usable, and production-ready: 


* This is probably the most naive possible implementation of anything in ARKit. There's a WHOLE lot that could be enhanced here.

   * It would be great to leave the AR session active while backing up the navigation stack, and put more than one product into it.
   * Support Resize/move for the 3d objects.
   * Lighting estimation would help the AR objects blend into the real world better. As is, they seem a little stark.
   * Currently all photo plane objects are oriented perpendicular to the direction the camera was facing when the AR session started. I'd prefer they be placed facing the camera at the time of insertion. It turns out that detecting the camera's orientation is a complex thing that I didn't have time to understand for this exercise.


* For UI simplicity I limited the app to iPhone. ARKit runs great on iPad, so it would be nice to support that.

* It needs Unit/UI tests before I'd call it production-ready.

* Search results are retained only in memory. A production app should use some durable storage (Core Data or at least a small SQLite db). That way if the app was dismissed in the middle of the workflow, we could come back to exactly where you left off last time rather than always starting the user at the top of the search process.

* Rebuild the product detail page to show more fields, and to scale the whole page (inside a scroll view, for vertical overflow) to fit the description content. In other words, rather than the description field itself being scrollable, I would like the description field to scale itself vertically to fit its contents, and then let the whole screen scroll.

* I'm only showing the first page of search results that the API provides (configured to be 15 items). A complete version of this should be able to navigate the paginated search results.

* I would have liked to refactor the API access networking code into a single API client class. Since we have only two calls and both have quite different work to do with the data they receive, I left the networking code in the view controllers themselves, which isn't ideal.

* A production version of this would need to test for network accessibility, and do something sensible if it's unable to reach the API. This version of the app will just hang and fail if it's run offline.


ACKNOWLEDGEMENTS / DEPENDENCIES

I used the following open source packages:

SDWebImage (https://github.com/rs/SDWebImage)

ARKit-Sample-ObjC (https://github.com/rajubd49/ARKit-Sample-ObjC)


