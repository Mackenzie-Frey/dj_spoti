# README
## Description

DJ Spoti is an 11-day, four-person project during Mod 3 of 4, for Turing School's Back-End Engineering Program.

Our challenge was to create a web application from idea to inception. Project requirements include: authentication with a third-party service, consuming an api, and solving a real-world problem.

Thus, DJ Spoti was born. DJ Spoti is a web application designed to solve the problem of one person being in charge of the music at a party and being unable to take into account all of the music preferences of their fellow party-goers. DJ Spoti enables users to create a collaborative music experience by logging into the app and inviting their friends via a text message. From there, DJ Spoti aggregates the favorite songs of all session party users and cultivates a playlist with all user preferences in mind.

DJ Spoti utilizes the languages of Ruby, HTML, CSS, the web framework of Rails, and authentication via Spotify OAuth. The Spotify API is utilized to consume user playlist preference data.

#### [**_View DJ Spoti in Production_**](https://dj-spoti.herokuapp.com/)
![image](https://user-images.githubusercontent.com/42525195/56476179-47b9d380-6451-11e9-9829-ff250c432a22.png)

![image](https://user-images.githubusercontent.com/42525195/56476209-a2532f80-6451-11e9-87ef-23a1ebaeb03b.png)

![image](https://user-images.githubusercontent.com/42525195/56476185-5bfdd080-6451-11e9-9592-4db6c48a6115.png)

![image](https://user-images.githubusercontent.com/42525195/56476188-6ae48300-6451-11e9-94d7-bb88830caacf.png)

![image](https://user-images.githubusercontent.com/42525195/56476192-75068180-6451-11e9-86d0-c418d75f76d0.png)

## Schema
![image](https://user-images.githubusercontent.com/42525195/56476372-d6c7eb00-6453-11e9-8a53-eedc34bafe28.png)

## Getting Started

To run DJ Spoti on your local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:

```
$ git clone git@github.com:Mackenzie-Frey/dj_spoti.git
$ cd dj_spoti
$ bundle
$ rails g rspec:install
$ rails db:create
$ rails db:migrate
$ bundle exec figaro install
```
### Environment Variable Setup

###### Sign Up on the following API:
* [Spotify](https://developer.spotify.com/documentation/web-api/quick-start/)

Add the following code snippet to your `config/application.yml` file. Make sure to insert the key/secret without the alligator clips ( < > ).
```
SPOTIFY_CLIENT_ID: <insert>
SPOTIFY_CLIENT_SECRET: <insert>
```

### Running Tests

To run the test suite, execute the following command:
`rspec`.
<!-- add to this section if a background worker is implemented  -->


### Deployment

To view DJ Spoti in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.

To view the application in production, from the project directory, execute the following commands:
```
$ createuser -s -r dj_spoti
$ RAILS_ENV=production rake db:{drop,create,migrate}
$ rake assets:precompile
$ rails s -e production
```

## Tools Utilized:

<!-- * <Continuous Integration> -->
* Figaro
* Faraday
* Shoulda-Matchers
* Factory Bot
* Spotify OAuth
* Spotify API
* Bootstrap
* GitHub & GitHub Projects
* FactoryBot
* RSpec
* Capybara
* Pry
* RuboCop
* Launchy
* SimpleCov
* PostgreSQL
* Chrome Dev Tools
<!-- * <insert background workers> -->
<!-- * <insert tool for speed optimization evaluation> -->

## Rubric/Project Description
http://backend.turing.io/module3/projects/terrificus

## Project Management
[GitHub Project Board](https://github.com/Mackenzie-Frey/dj_spoti/projects/1)

## Authors

* [Manoj Panta](https://github.com/manojpanta)
* [Teresa M Knowles](https://github.com/teresa-m-knowles)
* [Peregrine Reed Balas](https://github.com/PeregrineReed)
* [Mackenzie Frey](https://github.com/Mackenzie-Frey)


## Acknowledgments

* [Josh Mejia](https://github.com/jmejia)
* [Mike Dao](https://github.com/mikedao)
