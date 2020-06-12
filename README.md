Welcome to SaveMySeat! Let's get to eating.

## App Description

This app uses information from the Yelp API to allow users to make and store reservations at restaurants of their choosing. Users search for restaurants by attribute (type of food, type of establishment) and by location (city, zipcode, address, neighborhood). 

## Download Instructions

To download, clone this repository down onto your device. Run 'bundle install' to install any
necessary gems.

To start the application, simply create a new instance of the 'SaveMySeat' class in the file you intend to run, and call #run on that method. For example:

ruby
----------

reservation_app = SaveMySeat.new
reservation_app.run

-----------

## App Navigation Instructions

Once you have successfully installed and opened the application, create a new password/username when prompted and enter your first search!

The application can execute searches for any number of prompts, including types of food like 'chinese', 'italian', 'burgers', and 'tacos', as well as types of businesses, such as 'bar', 'deli',
etc. Likewise, the location search can take a city name/abbreviation such as 'NYC', a specific address, a zip code or an entire state. 

The application will then return a list of the top ten search results based on the sorting method of your choosing. The default and first choice is 'best match', which will simply look for the closest match to your search. You can also sort by average review rating, number of reviews, and price, all in either ascending or descending order.

Once you've executed your first search, the application will ask if you would like to make a reservation at any of the above restaurants. If yes, input the full name of the restaurant of your choice as it appears in the table, and the application will return a list of that restaurant's business hours. Input your date and time of choice as prompted, confirm your restaurant choice, date, and number of guests, and your reservation will be saved to your account!

If you wish to view your confirmed reservations, simply choose the 'View reservations' option from the home page. The application will print a list of the reservations saved to your account and then ask if you would like to delete any of them. You can delete all past reservations or choose a specific reservation to delete, for which you would input the restaurant name and date/time. 

Once you're satisfied and ready to close the application, simply choose 'Log out' from the home menu and your current reservations will be saved to the database so that you can log in and access them at any time.

