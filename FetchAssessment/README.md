### Summary: 
Recipe List:

- Displays a list of recipes fetched from the API.

Each recipe shows its name, cuisine type, and photo.

- Photos are loaded lazily and cached to disk for efficient network usage.

Pull-to-Refresh:

- Users can refresh the recipe list by pulling down on the list or using a refresh button.

Error Handling:

- If the API returns malformed data, the app displays an error message.

- If the recipe list is empty, the app shows an empty state message.

Image Caching:

- Images are cached to disk to avoid repeated network requests.

- Images are loaded only when they appear on the screen.

Clean UI:

- Built using SwiftUI, the app has a modern and intuitive interface.


### Focus Areas: 

Efficient Network Usage:

 - Loading images on-demand (lazy loading) to minimize bandwidth usage.
 - Cache images to disk to avoid repeated network requests.

Error Handling:

 - Handled malformed data gracefully by disregarding the entire list and showing an error message.
 - Displaying an empty state if the recipes list is empty.

Testing:

 - Wrote unit tests for core logic, including data fetching, parsing, and caching.
 - Ensured edge cases (malformed data, empty data) are covered.

### Time Spent: 

I spent aroung 7-8 hours of time to build this app. Due to my work I was not able to do it all at once. So, It took longer than required.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

 UI part

### Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part of the project is likely the image caching implementation. While it works for the scope of this project, it lacks advanced features like cache expiration, size limits, or memory caching. In a production environment, this could lead to excessive disk usage over time.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
