# This is a learning project

Eventually this is supposed to be a website for a citizens' initiative. It'll have a few pages of scrollable lists of posts, containing news, campaign infos and press releases. 

To give them the ability to update these posts them self, I want to implement authorization and, when authorized, the creation and modification of posts via a markdown editor.

Posts will be saved on and retrieved from Firebase FireStore. Cause images are an important aspect of these posts, a separate solution to handle the upload and storage of images may have to be found. Maybe the other storage solution of Firebase is better suited to handle images. 

# Packages
_This is a non-exhaustive list of used third party packages. An exhaustive list can be found in the pubspec.yaml file._   

- State Management: [provider](https://pub.dev/packages/provider)
- Routing:          [go_router](https://pub.dev/packages/go_router)
- Markdown(considering):          
    - [flutter_markdown](https://pub.dev/packages/flutter_markdown)
    Only display. Works.
    - [simple_markdown_editor](https://pub.dev/packages/simple_markdown_editor) 
    Full solution with toolbar. Does not break, but losses focus when toolbar is used. Toolbar not functional.
    - [markdown_editable_textinput](https://pub.dev/packages/markdown_editable_textinput)
    Full solution with toolbar. Breaks. Not null-safety compatible?
    - [markdown_toolbar](https://pub.dev/packages/markdown_toolbar)
    Separate toolbar. Will use if I have to use flutter_markdown. 
- Validation:       [validation_pro](https://pub.dev/packages/validation_pro)
- Loading Animation: [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)

# Architecture
_This is how the codebase is structured._

## Logging
I'v written a wrapper for the _log()_ function in _dart:developer_ which is just named _log(object)_. It will take any object and ToString it and then output this to the debug console together with the filename and code-line where the log originates (stacktrace). This is a functionality which I have not been able to find in existing libraries, in this simplicity. 

**TODO:** Make the stacktrace a clickable link.

## File Structure
Files are organized in four categories:
1. Views
    - Page-like widgets that are either complete routes or container of routes. 
    - The app should never display more then one view if the same type at the same time. If thats the case, make it into a module.
    - **SuperView** has the **Scaffold** with the **AppBar** and gets returned by the builder of the **ShellRoute**.
    - **ContentView** wraps the view-widgets displaying the actual content. This gets returned by the _getChild()_ function of the **RouteService**, which is called by the builder of the **GoRoute**s, that get created with a _map()_ method on a list of routes to fill the routes parameter of the **ShellRoute**. 
2. Modules
    - Smaller parts of the interface that a page might use more then one of. Examples are the widgets displaying a post or an markdown editor.
3. Services
    - Manager-like classes that combine non-widget-specific functionality and state, that are grouped by responsibility.
    - I'm using these as global state-holders, a bit like one would use singletons. All services are provided to the widget-tree from the head of the tree at main.dart. This basically makes them global.
    - I don't know if this a acceptable practice to mix state with business-logic. It works for me, but if someone has good reasons against this practice AND practical alternative implementations, I'm very open to learn.    
4. Models
    - Data models like user or post.
5. Trash
    - Since I'm still learning, I find it useful to have some currently unused code lying around. 

## Naming
_I generally try to stick to the official [style guide](https://dart.dev/effective-dart/style)._

Additional I name (not jet everywhere implemented) every files and classes with the appropriate category as suffix. I.e. **route_service** for the file and **RouteService** for the class.

# Challenges
_Following features are, or are expected to be, challenging._

## "Box Constrains forces infinite height"
I'm using GoRouter and a CustomTransitionPage to handle routing and animate it. Somewhere between the router and the page-content is a Container, or something similar, that forces an infinite height. 

The parental relationships look like that (as far as im aware):
ShellRoute -> SuperView -> GoRoute -> ContentView -> PageContent

It works when I give the child of the SuperView a Container with a fixed height, but this will not be sufficient for loading posts with a length which is unknown at compile-time. 

## Markdown Editing
I've not been able to get the different markdown-libraries I tried to work. Some have dependency issues. Some provide buttons that don't work (might be a problem withe focus or the clickable area of the parent container). 

The only one working so far is flutter_markdown and with this, I'm worried that it'll be to complicated for the users (the members of this citizens' initiative), since one would have to mark every line break by hand etc.

## Database
To limit the challenge of this project, I would like the stay in the Firebase ecosystem. Firebase offers two database solutions. Both are NoSQL Databases.
1. Cloud Firestore
2. Realtime Database
[Documentation](https://firebase.google.com/docs/database/rtdb-vs-firestore)

Saving posts as strings in a document in a collection in Cloud Firestore has been an easy task. The dynamic loading of the posts when the page loads might a point of possible friction.

Also, integrating pictures into the posts (a requested feature), is possibly not straight forward. The post creation process must contain some way of previewing the whole post incl. the pictures. Maybe a separate uploading process that yields a link to the picture which then can be used in the markdown is a possible way. But I don't know jet if storing the pictures on Cloud Firestore yields a link to that picture. Cause it's not a file on a file on a sever, but an entry in a DB as far is I understand it.

I've heard that Cloud Firestore is more expensive when storing images, Realtime Database might be the better option for that. 

Offline database might be a nice addition. I imagine this would reduce load-time after the initial load and so improve the responsiveness for users with low bandwidth, which might be frequent cause the members of the citizens' initiative are mostly old people living in rural areas in northern germany.

**TODO:** Research and test, file uploading from the live app and possible libraries, that interface with the OS-filesystem.

**TODO:** Compare and test both Cloud Firestore and Realtime Database.

# Notes
I'm generally very happy to read constructive criticism. 

Thank you for being a helpful part of the community. :)