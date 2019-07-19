# README

This app is deployed to stripe-marketplace.herokuapp.com

# How It Works

This is built with the newest rails 5.2! This gave me a chance to check out ActiveStorage and the new rails secrets conventions, both of which worked wonderfully!

It will start off as an empty table of products. Sign in with your stripe account by clicking the bottom link. You can then add new products to the store with attached images.
You cannot buy your own products, but you can view them and edit them.
Sign out of your stripe account and you can then proceed to the new stripe checkout page (discussed below)
After successful payment is processed you will be sent to a purchase confirmation page and the product will no longer be shown in the store.

# Future Considerations

More error handling for edge cases. I didn't make a 404/500 page and errors will be thrown if you access a bad product id (i.e. `products/9999999`) will throw an error.

We should create tests using the VCR gem for mocking actual requests from the stripe service. Those are fairly time consuming to set up.

The "purchase confirmation" page is pretty hacky logic and should have a charge id attached to a purchase to look up rather than the most recent purchase. It's also unprotected so any user could hit that page and get the "confirmation"

Obviously CSS and UI fixes improvements are numerous, but this does the trick.

# Known Issues

This was built with the newest version of Stripe Checkout as the older version has been recently deprecated.
Therefore, it is impossible to make charges directly on the connected stripe account with tokenizing a credit card as the charge is made immediately. I have mocked what it would look like by passing `tok_visa` to the Stripe::Charges method. Therefore there will be two charges per transaction.
Also, the "confirmation" will just show the `tok_visa` card as well, but the logic would work if we subbed in an actual token using other methods.

Since this is run on the free heroku app with localhost as the image storage, images will be deleted when heroku spins down after not being active for a few minutes. This can be avoided by either uploading the images to S3 or by paying for an upgraded heroku instance. For the sake of time I decided this was fine.
