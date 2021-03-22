# Run it all

To run the whole recognition setup, you can simply
`docker-compose up`

This will start the **db**, the **classifier** the **connector** and the **bff**. You can then visit http://localhost:4200

In order to link your own ring device, you will need to provide your own `oauth-autorization.json` file. Please see the connector project for details on creating this file.

