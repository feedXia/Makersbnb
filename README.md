# MakersBnB

MakersBnB Group Project by Alex, Delia, Ewa, Xia and Sasha.

In this project we are tasked to build a web application that allows users to list spaces they have available, and to hire spaces for the night.

### User stories

```
As a user,
so I can use the website, I need to sign in.
If I don't have an account I can make one.

As a host,
So I could show my property,
I would like to be able to list a new space.
Listing involves settings price, name, and description and date availability.

As a host,
So I could see my properties,
I would like to see all the properties that I have listed.

As a host,
So I can lend the property,
I would like to approve/deny rent requests.

As a guest,
So I could rent a place for a night,
I would like to see all the properties available from all hosts.

As a guest,
To book a place,
I would like to make a request to the property.

As a guest,
I would like to see available dates for a particular property.

As a guest,
I cannot book a property that has already been booked.

As a host,
I can receive many bookings request for different time periods.
I can choose which request to accept.
If time periods overlap, the alternate requests will be denied.
```

### Headline specifications

- [ ] Any signed-up user can list a new space.
- [ ] Users can list multiple spaces.
- [ ] Users should be able to name their space, provide a short description of the space, and a price per night.
- [ ] Users should be able to offer a range of dates where their space is available.
- [ ] Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- [ ] Nights for which a space has already been booked should not be available for users to book that space.
- [ ] Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- [ ] Users should receive an email whenever one of the following happens:
- [ ] They sign up
- [ ] They create a space
- [ ] They update a space
- [ ] A user requests to book their space
- [ ] They confirm a request
- [ ] They request to book a space
- [ ] Their request to book a space is confirmed
- [ ] Their request to book a space is denied
- [ ] Users should receive a text message to a provided number whenever one of the following happens:
- [ ] A user requests to book their space
- [ ] Their request to book a space is confirmed
- [ ] Their request to book a space is denied
- [ ] A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- [ ] Basic payment implementation though Stripe.

### How to Setup

1. Fork & clone this Repo
2. Run `bundle`
3. Follow the files in db/migrations to setup database

### To set up a database
Connect to `psql` and create the `makers_bnb` and `makers_bnb_test` databases:
```
CREATE DATABASE makers_bnb_test;
CREATE DATABASE makers_bnb;
```
To set up the appropriate tables, connect to each database in psql (e.g. `\c makers_bnb`) and run the SQL scripts in the db/migrations folder in the given order.



### Project Planning

[MVP Plan Document](https://docs.google.com/document/d/1YVyuk1QwdJ5Y2rO0yJztMdj6gMfILxxr_OBLLilKB5c/edit#)

### Domain Modelling

![Class Diagram](https://lucid.app/publicSegments/view/b27c7c58-1867-4130-a48b-47874648b003/image.png)

### MVC Diagrams

![View Spaces](https://github.com/feedXia/Makersbnb/blob/20afbe59944a5181ca8d1cf7c2b85f2a0b37262d/images/View%20spaces%20model.png)

![Add Spaces](https://github.com/feedXia/Makersbnb/blob/20afbe59944a5181ca8d1cf7c2b85f2a0b37262d/images/Add%20spaces%20model.png)

