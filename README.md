# Run it all
![Ringface2](https://user-images.githubusercontent.com/7328002/112138818-3f84e880-8bd2-11eb-9ded-2e17f2d5da74.gif)


## Attach your own doorbell
In order to link your own ring doorbell, you will need to provide your own `oauth-autorization.json` file. 

This is easiest done by running a special container for downloading the authorization info. The python script in the contaier will ask for your ring credentials, possibly second factor, if you enabled that, and create the required file `oauth-autorization.json` in the current dir.
```bash
docker run -a stdin -a stdout -it -v $(pwd):/app/output ringface/createauth
```
After the container has finished, you will find the `oauth-autorization.json` in the current dir. It is time to run some recognition.

## Start the application
To run the whole recognition setup, you can simply run
`docker-compose up`. 

This will start the **db**, the **classifier** the **connector**  the **bff** and the **nginx** server with the angular bundle of the GUI. You can then visit the angular GUI at http://localhost:4300

## Use the application
You should start by downloading the latest videos from your ring device. On http://localhost:4300 open the Today accordion, and click the **Download events button**. In the ./data/videos dir, you will find the newly downloaded videos.

Once the videos are dowloaded, you can click the **Recognise** button on the event. This will process the video file, and find the faces. 

Once faces have been found, you can click the **Tag person** button. Further recognition runs will recognise this person automatically.
