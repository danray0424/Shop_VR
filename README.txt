Shop VR

Market America coding sample
Dan Ray
dan@danray.net
919-824-1216


OVERVIEW

This app allows the user to place and interact with product images from shop.com on a plane in 3d space, using the iOS ARKit augmented reality API.

The first screen allows the user to query the Shop.com product search API with a search term of their choosing. It displays a list of results.

The user can drill down to a detail page on any of the listed results.

From there the user can place the product image on a detected plane AR space (e.g. a table top). You may need to "look around" a little--the app will let you know when it's detected a flat surface it can work with. Tap to add a card featuring the product image. The cards will stand up on the surface, and you can move around and explore them. Moving and scaling cards is not currently supported.



INSTALLATION / BUILD

The AR functionality won't run on the emulator. It requires an iPhone 6s or later, with iOS 11. 

Per request I'm delivering an IPA file, though I've never used the iTunes-sync method of installing a develoment build (I have lots of experience with TestFlight and Crashlytics for deploying to testers). I don't personally sync my devices to iTunes, so I'm not set up to test that method. 

I'd prefer you build directly to your phone. Please connect your phone to a mac running Xcode, and build/deploy the app from there. I've turned on automatic certificate management, so it should be a one-click deal (though it will need to submit your phone's ID to the certificate portal, and may take several minutes "preparing debugger support" on your phone; you should let it do these things). 

Select your phone from the devices section of the Schemes drop down in the Xcode toolbar and hit the "play" button.

Be sure you open the project from the workspace "Shop VR.xcworkspace" so Xcode will pick up and build the Pod dependencies project.

If you have trouble installing this way, let me know and I'll set the app up in Crashlytics and get it to you that way.


DEVELOPMENT COMMENTS

I elected to build this in native Objective-C as it's the platform I'm most familiar and fastest with. I used a standard iOS UINavigationView structure, drilling down from search control to results to details to the payoff on the AR screen. This navigational idiom is common and familiar to iOS users.

For simplicity, I limited the app to iPhones, and eliminated device rotation support. 

I used auto-layout to design the interfaces. The design ought to more or less survive any iPhone screen geometry. Auto-layout can be VERY complicated to learn, but once you understand how it thinks, it's totally the tool for the job.

On the product detail page, I noticed that the product description is expressed in HTML. I'm rendering it in a WKWebView, which currently doesn't allow the developer to set a zoom level. So it's pretty tiny. I'd prefer that that control re-size itself vertically to fit the size of the content, and that the whole screen be embedded in a scroll view for vertical overflow. That used to be doable (via javascript trickery) with UIWebView, but that's now deprecated.

The AR stuff is a bit of a black box--both the helper code I imported for it, and the API itself. 

In response to the "Style the application beyond base styling", I implemented a custom app icon and a custom launch screen. Apart from that the 


TODOS / KNOWN ISSUES

There are MANY iteration targets for this app, to make it more feature rich, usable, and production-ready: 


* This is probably the most naive possible implementation of anything in ARKit. There's a whole lot that could be fine tuned here.

  * It would be great to leave the AR session active while backing up the navigation stack, and put more than one picture into it.
  * Support Resize/move for the 3d objects.
  * Lighting estimation would help the AR objects blend into the real world better. As is, they seem a little stark.
  * Currently all photo plane objects are oriented perpendicular to the direction the camera was facing when the AR session started. I'd prefer they be placed facing the camera is at the time of the tap. But detecting the camera's translation through space while the AR session is in flight appears to be a dark art.


* For UI simplicity I limited the app to iPhone. ARKit runs great on iPad, so it would be nice to support that.

* Unit/UI tests would be extremely good to have.

* Search results are retained only in memory. A production app should use some durable storage (Core Data or at least a small SQLite db).

* I'm only showing the first page of search results that the API provides (configured to be 15 items). A complete version of this should be able to navigate the paginated search results.

* I would have liked to refactor the API access networking code into a single API client class. Since we have only two calls and both have quite different work to do with the data they receive, I left the networking code in the view controllers themselves, which isn't ideal.

* A production version of this would need to test for network accessibility, and bellyache if it's unable to reach the API. This version of the app will just hang and fail if it's run offline.



ACKNOWLEDGEMENTS/EXTERNALITIES

I used the following open source packages:

SDWebImage (https://github.com/rs/SDWebImage)
ARKit-Sample-ObjC (https://github.com/rajubd49/ARKit-Sample-ObjC)


