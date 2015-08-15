# ToolKit
ToolKit is a pack of libraries designed with an idea to create components which can work together efficiently, taking as less responsibilities (one by one) as much as possible.

Today's pods mostly offers solutions for a specific problem, however they also contain solutions for problems which shouldn't be their responsibility. Have you ever found yourself in a situation where you had multiple caching mechanisms, networking solutions or error/app/user tracking libraries in your app just because several pods implicitly contains their own partial solutions for the same problem? If you want to have one solution for one problem and get rid of all to other attached, never used code parts, then ToolKit is for you!

On the other hand, you are the one who needs to connect these components! No automatic image caching with networking, you have to connect the components behaviour in your code. 

It's in alpha phase currently, so expect even some interface changes as well!

For further documentation of the components, check the ToolKit folders.

