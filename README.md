# MarvelList

This is a list of superheroes which you can tap on to view more detail about three of the comics they're featured in.

Future improvements:

* Add image caching. AsyncImage is supposed to handle this for you but when scrolling away and then back the images are not loaded instantly.
* Handle errors in UI. Errors are not currently handled properly.
* Add empty state UI.
* Explore the possibility of using Async/await instead of publishers/Combine.
* Small thing but the `HeroView` placeholder is left-aligned but should be centered.
* Lots more unit tests (for example testing the pagination logic).
* Put API keys in ENVConstants or `swift` file which is shared separately
* Introduce an `Interactor` between the `Repository` and the `ContentViewModel`. Currently The `ContentViewModel` does too much in my opinion.
