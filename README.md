# Run it all

To run the whole recognition setup, you can simply run
`docker-compose up`

This will start the **db**, the **classifier** the **connector**  the **bff** and the **nginx** server with the angular bundle of the GUI. You can then visit the angular GUI at http://localhost:4200

In order to link your own ring doorbell, you will need to provide your own `oauth-autorization.json` file. Please see the connector project for details on creating this file.

