# wp_client

testing out wordpress rest api. to start wordpress run `docker-compose up` in the same directory as this file. the first time you will need to set it up. My test user credintials are in the `constants.dart` file. You will need to update that file with whatever user account you want to test with (this is JUST for testing... don't ever do this in real code)

### Wordpress Settings

  1) from Dashboard after initial setup, click on settings from the side bar
  2) Goto the "Permalinks" section there
  3) pick one of the options, besides plain

### Testing it's working

If you can get to [http://localhost:8080/wp-json/](http://localhost:8080/wp-json/) and see the rest api layout data than you have your Wordpress set up properly for local dev with this app!