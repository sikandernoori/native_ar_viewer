# native_ar_viewer

A flutter plugin to quickly view 3D models in AR in Flutter using Android SCENE VIEW and IOS QUICK LOOK.

## Supported formats.

Android -> GLB, GLTF.
IOS -> USDZ.

Example App Demonstrates how to use the native_ar_viewer plugin for Android. For IOS you have to pass file path from local directory.

## Usage

```await NativeArViewer.launchAR(modelURL);```

## Example App

Example app Demonstrates how to use the native_ar_viewer plugin for Android and IOS. 
For Android you can directly pass URL of remote 3D asset.
For IOS you have to pass file path from local directory. (Boilerplate sample is provided on how to download remote assets)

## IOS possible solution

You can download and save remote assets using flutter_downloader package by flutter community.
After saving pass the file path to native_ar_viewer -> launchAR function.

but that's one solution, you can modify as per your custom needs.

IOS Quick Look does not support loading assets from remote URL.

